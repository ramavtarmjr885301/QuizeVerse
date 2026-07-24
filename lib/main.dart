import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizverse/screens/onboarding_screen.dart';
import 'package:quizverse/screens/profile_screen.dart';
// import 'package:quizverse/scripts/bulk_upload_questions_batch2.dart';
// import 'package:quizverse/scripts/bulk_upload_questions_batch7.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizverse/firebase_options.dart';
import 'package:quizverse/providers/user_provider.dart';
import 'package:quizverse/providers/quiz_provider.dart';
import 'package:quizverse/screens/splash_screen.dart';
import 'package:quizverse/screens/login_screen.dart';
import 'package:quizverse/screens/home_screen.dart';
import 'package:quizverse/screens/quiz_screen.dart';
import 'package:quizverse/screens/result_screen.dart';
import 'package:quizverse/screens/leaderboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await bulkUploadQuestionsBatch7();
  // await checkQuestionCount();

  // Initialize Mobile Ads
  await MobileAds.instance.initialize();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(QuizVerseApp(prefs: prefs));
}

class QuizVerseApp extends StatelessWidget {
  final SharedPreferences prefs;

  const QuizVerseApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(prefs: prefs)),

        // ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider(prefs: prefs)),
      ],
      child: MaterialApp(
        title: 'QuizVerse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF6C63FF),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6C63FF),
            secondary: Color(0xFFFF6584),
            tertiary: Color(0xFF00D2FF),
            surface: Color(0xFF1A1A2E),
            background: Color(0xFF0F0F1A),
          ),
          scaffoldBackgroundColor: const Color(0xFF0F0F1A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A1A2E),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // ✅ FIX: CardTheme → CardThemeData
          cardTheme: const CardThemeData(
            color: Color(0xFF1A1A2E),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/quiz': (context) => const QuizScreen(),
          '/result': (context) => const ResultScreen(),
          '/leaderboard': (context) => const LeaderboardScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
