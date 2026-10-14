
require("dotenv").config();

const express = require("express");
const fs = require("fs");
const path = require("path");

const { GoogleGenAI } = require("@google/genai");
const { initializeApp, cert } = require("firebase-admin/app");
const { getAuth } = require("firebase-admin/auth");

const app = express();
const PORT = Number(process.env.PORT || 3000);

// --------------------------------------------------
// Environment and Firebase configuration
// --------------------------------------------------

if (!process.env.GEMINI_API_KEY) {
  console.error("Missing GEMINI_API_KEY in backend/.env");
  process.exit(1);
}

const serviceAccountPath = path.join(
  __dirname,
  "service-account.json"
);

if (!fs.existsSync(serviceAccountPath)) {
  console.error("Missing backend/service-account.json");
  process.exit(1);
}

const serviceAccount = JSON.parse(
  fs.readFileSync(serviceAccountPath, "utf8")
);

const firebaseApp = initializeApp({
  credential: cert(serviceAccount),
});

const firebaseAuth = getAuth(firebaseApp);

const ai = new GoogleGenAI({
  apiKey: process.env.GEMINI_API_KEY,
});

app.use(express.json({ limit: "40kb" }));

// --------------------------------------------------
// Tutor levels
// --------------------------------------------------

const TutorLevel = Object.freeze({
  GUIDING: 1,
  HINT: 2,
  EXPLANATION: 3,
});

const helpPatterns = [
  /\bhint\b/i,
  /\bhelp me\b/i,
  /\bmore help\b/i,
  /\bnext step\b/i,
  /\bnot sure\b/i,
  /\bi don't know\b/i,
  /\bi dont know\b/i,
  /\bi'm stuck\b/i,
  /\bim stuck\b/i,
  /\bconfused\b/i,
  /\bstill don't understand\b/i,
  /\bstill dont understand\b/i,
  /\bexplain (it|more|further)\b/i,
  /\bshow me\b/i,
];

function requestsMoreHelp(message) {
  return helpPatterns.some((pattern) => pattern.test(message));
}

function getTutorLevel(message, history) {
  const userMessages = history
    .filter((item) => item.role === "user")
    .map((item) => item.text);

  // Start each new conversation with a guiding question.
  if (userMessages.length === 0) {
    return TutorLevel.GUIDING;
  }

  // Count explicit requests for more help in recent messages.
  const helpRequests = userMessages
    .slice(-8)
    .filter(requestsMoreHelp).length;

  const currentHelpRequest = requestsMoreHelp(message);

  if (!currentHelpRequest) {
    return TutorLevel.GUIDING;
  }

  if (helpRequests >= 1) {
    return TutorLevel.EXPLANATION;
  }

  return TutorLevel.HINT;
}

// --------------------------------------------------
// System instructions
// --------------------------------------------------

const baseInstructions = `
You are Thinksy, a friendly AI learning companion
for first-semester Fontys ICT students.

Your main objective is to improve students'
independent thinking and problem-solving abilities.

Teaching principles:

1. Encourage students to reason about problems.
2. Use simple, beginner-friendly language.
3. Adapt your explanations to the student's knowledge.
4. Avoid immediately completing entire assignments.
5. Provide small illustrative code examples when useful.
6. Never pretend to know private Fontys student information.
7. Be encouraging, respectful, and occasionally funny.
8. If a student shares their attempt, give useful feedback.
9. Avoid repeating the same guiding question endlessly.
10. Correct misconceptions clearly and constructively.

Important:
Students must receive useful educational guidance,
not just repeated questions.

When explaining a concept, provide enough context
for the student to make progress.
`;

function buildTutorInstructions(level) {
  if (level === TutorLevel.GUIDING) {
    return `
${baseInstructions}

CURRENT TUTOR LEVEL: 1 - GUIDING

Your approach:
- Give a short explanation of the key concept.
- Ask one specific guiding question.
- Encourage the student to think about the next step.
- Do not immediately produce a complete assignment solution.
- Keep the answer concise and useful.

Example:
Student: How do I create inheritance in Java?
Thinksy: Inheritance lets one class reuse behavior
from another. Think about a Car and a Vehicle:
which one is the more general class?
`;
  }

  if (level === TutorLevel.HINT) {
    return `
${baseInstructions}

CURRENT TUTOR LEVEL: 2 - HINT

The student needs additional help.

Your approach:
- Acknowledge what the student is struggling with.
- Give one concrete, actionable hint.
- Introduce relevant terminology or syntax if needed.
- Use a tiny example if useful.
- Ask one question that helps the student continue.
- Avoid completing an entire assignment.

Example:
Student: I still need help.
Thinksy: In Java, a subclass uses the keyword
"extends" to inherit from a parent class.
Where would you place that keyword in
a Car and Vehicle class declaration?
`;
  }

  return `
${baseInstructions}

CURRENT TUTOR LEVEL: 3 - EXPLANATION

The student has requested additional help repeatedly.

Your approach:
- Provide a clear step-by-step explanation.
- Explain the reasoning behind each step.
- Include a small code example when appropriate.
- Explain why the example works.
- Help the student apply it to their own problem.
- Do not generate a complete submission-ready assignment.
- End with one practical question or exercise.

Example:
Student: I still don't understand.
Thinksy: In Java, inheritance uses "extends".

Example:
class Vehicle {
    void move() {
        System.out.println("Moving");
    }
}

class Car extends Vehicle {
}

Car inherits the move() method from Vehicle.

Why? Because Car extends Vehicle.

Now, what would happen if you called move()
on a Car object?
`;
}

// --------------------------------------------------
// Health endpoint
// --------------------------------------------------

app.get("/health", (req, res) => {
  res.json({
    status: "ok",
    application: "Thinksy Backend",
    tutor: "Progressive Learning",
  });
});

// --------------------------------------------------
// Chat endpoint
// --------------------------------------------------

app.post("/chat", async (req, res) => {
  try {
    // Verify Firebase login
    const authorization = req.headers.authorization || "";

    if (!authorization.startsWith("Bearer ")) {
      return res.status(401).json({
        error: "Authentication required.",
      });
    }

    const token = authorization.slice(7);

    try {
      await firebaseAuth.verifyIdToken(token);
    } catch (error) {
      console.error(
        "Firebase authentication error:",
        error.message
      );

      return res.status(401).json({
        error: "Invalid or expired login session.",
      });
    }

    // Validate message
    const { message, history = [] } = req.body || {};

    if (
      typeof message !== "string" ||
      message.trim().length === 0 ||
      message.length > 3000
    ) {
      return res.status(400).json({
        error: "Please enter a message under 3000 characters.",
      });
    }

    // Validate conversation history
    const safeHistory = Array.isArray(history)
      ? history
          .slice(-10)
          .filter(
            (item) =>
              item &&
              (item.role === "user" || item.role === "model") &&
              typeof item.text === "string" &&
              item.text.length > 0 &&
              item.text.length <= 3000
          )
          .map((item) => ({
            role: item.role,
            text: item.text,
          }))
      : [];

    // Determine tutoring level
    const tutorLevel = getTutorLevel(
      message.trim(),
      safeHistory
    );

    const systemInstruction =
      buildTutorInstructions(tutorLevel);

    console.log(
      `Thinksy tutor level: ${tutorLevel}`
    );

    // Prepare Gemini conversation
    const contents = [
      ...safeHistory.map((item) => ({
        role: item.role,
        parts: [{ text: item.text }],
      })),
      {
        role: "user",
        parts: [{ text: message.trim() }],
      },
    ];

    // Generate AI response
    try {
      const response = await ai.models.generateContent({
        model: "gemini-2.5-flash",
        contents,
        config: {
          systemInstruction,
          temperature: 0.5,
          maxOutputTokens: 850,
        },
      });

      const reply = response.text?.trim();

      if (!reply) {
        return res.status(502).json({
          error: "Gemini returned an empty response.",
        });
      }

      return res.json({
        reply,
        tutorLevel,
      });
    } catch (error) {
      console.error("Gemini error:", error.message);

      if (error.status === 429) {
        return res.status(429).json({
          error:
            "Gemini rate limit reached. Please try again later.",
        });
      }

      return res.status(502).json({
        error: "Thinksy could not generate a response.",
      });
    }
  } catch (error) {
    console.error("Backend error:", error.message);

    return res.status(500).json({
      error: "Unexpected server error.",
    });
  }
});

// --------------------------------------------------
// Start backend
// --------------------------------------------------

app.listen(PORT, "127.0.0.1", () => {
  console.log(
    `Thinksy backend running on http://127.0.0.1:${PORT}`
  );
  console.log("Progressive tutoring enabled.");
});
