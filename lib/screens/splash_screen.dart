// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quizverse/providers/user_provider.dart';
// import '../providers/quiz_provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     // Initialize user
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     await userProvider.init();

//     // Pre-load questions
//     final quizProvider = Provider.of<QuizProvider>(context, listen: false);
//     await quizProvider.loadQuestions();

//     // Navigate to home or login
//     if (userProvider.isLoggedIn) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       // Auto sign in as guest
//       final success = await userProvider.signInAsGuest();
//       if (success && context.mounted) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else if (context.mounted) {
//         // Fallback - show login screen
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Theme.of(context).primaryColor.withOpacity(0.3),
//               Theme.of(context).scaffoldBackgroundColor,
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo/Icon
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Theme.of(context).primaryColor.withOpacity(0.5),
//                     blurRadius: 40,
//                     spreadRadius: 10,
//                   ),
//                 ],
//               ),
//               child: const Icon(Icons.quiz, size: 64, color: Colors.white),
//             ),
//             const SizedBox(height: 32),
//             Text(
//               'QuizVerse',
//               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 letterSpacing: 2,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Test Your Knowledge',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 fontSize: 18,
//                 color: Colors.white70,
//               ),
//             ),
//             const SizedBox(height: 48),
//             const CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 3,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'Loading...',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyMedium?.copyWith(color: Colors.white60),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/quiz_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Use WidgetsBinding to avoid build-phase errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Initialize user
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.init();

    // Pre-load questions
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    await quizProvider.loadQuestions();

    // Navigate to home or login
    if (mounted) {
      if (userProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Auto sign in as guest
        final success = await userProvider.signInAsGuest();
        if (success && mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.3),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.quiz, size: 64, color: Colors.white),
            ),
            const SizedBox(height: 32),
            Text(
              'QuizVerse',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Test Your Knowledge',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            Text(
              'Loading...',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
