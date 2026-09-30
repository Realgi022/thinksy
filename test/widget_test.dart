import 'package:flutter_test/flutter_test.dart';
import 'package:thinksy/app.dart';

void main() {
  testWidgets('Thinksy app loads welcome page', (WidgetTester tester) async {
    // Build the Thinksy application.
    await tester.pumpWidget(const ThinksyApp());

    // Verify that the welcome page is displayed.
    expect(find.text('Welcome to Thinksy'), findsOneWidget);
  });
}