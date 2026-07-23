// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import '../providers/user_provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     Future<void> _signInWithGoogle() async {
//       setState(() => _isLoading = true);

//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       final success = await userProvider.signInWithGoogle();

//       setState(() => _isLoading = false);

//       if (success && mounted) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Google sign in cancelled or failed.')),
//         );
//       }
//     }

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.quiz, size: 50, color: Colors.white),
//               ),
//               const SizedBox(height: 32),
//               Text(
//                 'Welcome to QuizVerse',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Play quiz, earn coins, and climb the leaderboard!',
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 48),
//               // Guest Login Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _signInAsGuest,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.person_outline),
//                             SizedBox(width: 12),
//                             Text(
//                               'Continue as Guest',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               OutlinedButton.icon(
//                 onPressed: _isLoading ? null : _signInWithGoogle,
//                 icon: const FaIcon(
//                   FontAwesomeIcons.google,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//                 label: const Text('Continue with Google'),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
//                   minimumSize: const Size(double.infinity, 56),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'No sign-up required. Play instantly!',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signInAsGuest() async {
//     setState(() => _isLoading = true);

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final success = await userProvider.signInAsGuest();

//     setState(() => _isLoading = false);

//     if (success && mounted) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to sign in. Please try again.')),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.quiz, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to QuizVerse',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Play quiz, earn coins, and climb the leaderboard!',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Guest Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signInAsGuest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(width: 12),
                            Text(
                              'Continue as Guest',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.white,
                ),
                label: const Text('Continue with Google'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No sign-up required. Play instantly!',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInAsGuest() async {
    setState(() => _isLoading = true);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await userProvider.signInAsGuest();

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign in. Please try again.')),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final success = await userProvider.signInWithGoogle();

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign in cancelled or failed.')),
      );
    }
  }
}
