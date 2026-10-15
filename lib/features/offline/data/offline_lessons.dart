
import 'package:thinksy/features/offline/data/models/offline_lesson.dart';

class OfflineLessons {
  static const List<OfflineLesson> all = [
    OfflineLesson(
      id: 'variables',
      title: 'Variables in Java',
      category: 'Java Basics',
      introduction:
          'Variables store values that a program can use and change.',
      question:
          'You want to store the age of a student. '
          'Which Java data type would you choose, and why?',
      hint:
          'Think about whether age usually needs decimal places.',
      explanation:
          'An int is a suitable choice for whole-number ages. '
          'For example: int age = 20; '
          'The type describes the kind of data, age is the variable '
          'name, and 20 is its initial value.',
    ),
    OfflineLesson(
      id: 'conditions',
      title: 'If Statements',
      category: 'Java Basics',
      introduction:
          'Conditional statements let a program make decisions.',
      question:
          'A student passes an exam when their grade is at least 5.5. '
          'What condition would you write?',
      hint:
          'Think about which comparison operator means '
          '"greater than or equal to".',
      explanation:
          'You can check whether grade >= 5.5. '
          'For example: if (grade >= 5.5) { ... }. '
          'The code inside the braces runs when the condition is true.',
    ),
    OfflineLesson(
      id: 'loops',
      title: 'For Loops',
      category: 'Java Basics',
      introduction:
          'Loops repeat instructions while a condition is satisfied.',
      question:
          'How could you print the numbers 1 through 5 '
          'without writing five print statements?',
      hint:
          'A for loop usually has an initial value, '
          'a condition, and an update.',
      explanation:
          'You could use: '
          'for (int i = 1; i <= 5; i++) { System.out.println(i); }. '
          'The counter starts at 1, increases by 1, '
          'and stops after reaching 5.',
    ),
    OfflineLesson(
      id: 'inheritance',
      title: 'Inheritance in Java',
      category: 'Object-Oriented Programming',
      introduction:
          'Inheritance allows one class to reuse and extend '
          'the behavior of another class.',
      question:
          'If Car is a type of Vehicle, which class should '
          'be the parent, and which should be the child?',
      hint:
          'Think about which concept is more general. '
          'Every car is a vehicle, but not every vehicle is a car.',
      explanation:
          'Vehicle is the parent class and Car is the child class. '
          'In Java, you can write: class Car extends Vehicle { }. '
          'Car inherits accessible properties and methods from Vehicle '
          'and can also define its own behavior.',
    ),
    OfflineLesson(
      id: 'methods',
      title: 'Methods in Java',
      category: 'Object-Oriented Programming',
      introduction:
          'Methods group instructions into reusable operations.',
      question:
          'You need to calculate the total of two numbers in '
          'several places. Why might a method be useful?',
      hint:
          'Consider what happens when the calculation needs '
          'to change later.',
      explanation:
          'A method avoids duplicating logic. '
          'For example: int add(int a, int b) { return a + b; }. '
          'You can call the method multiple times with different '
          'arguments, making code easier to maintain.',
    ),
    OfflineLesson(
      id: 'arrays',
      title: 'Arrays in Java',
      category: 'Java Basics',
      introduction:
          'Arrays store multiple values of the same type.',
      question:
          'You have five exam scores. Would you create '
          'five separate variables or use an array?',
      hint:
          'Think about which option makes it easier '
          'to process all five scores in a loop.',
      explanation:
          'An array is useful for storing related values. '
          'For example: int[] scores = {7, 8, 6, 9, 7};. '
          'You can access the first score using scores[0]. '
          'Java array indexes begin at zero.',
    ),
  ];
}
