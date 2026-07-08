import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizverse/main.dart';

void main() {
  // Setup SharedPreferences mock before each test
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('QuizVerse app starts without crashing', (
    WidgetTester tester,
  ) async {
    // Create prefs instance
    final prefs = await SharedPreferences.getInstance();

    // ✅ FIX: Use QuizVerseApp instead of MyApp
    await tester.pumpWidget(QuizVerseApp(prefs: prefs));

    // Verify app starts
    expect(
      find.text('QuizVerse'),
      findsNothing,
    ); // Splash screen shows logo, not text

    // Wait for splash screen to load
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // After splash, should navigate to home
    // Note: Firebase will auto-login guest, so home screen should appear
    expect(find.text('Quick Play'), findsOneWidget);
  });
}
