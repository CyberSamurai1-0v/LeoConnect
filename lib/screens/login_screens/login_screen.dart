import 'package:flutter/material.dart';
import 'package:leoconnect/services/auth_service.dart';
import 'login_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Sign out any existing Google session when the login screen is first shown
    _authService.signOut();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // First, ensure we're signed out to force account selection
      await _authService.signOut();

      // Then, attempt to sign in
      final userCredential = await _authService.signInWithGoogle();

      if (userCredential?.user != null) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginDetails()),
        );
      } else {
        if (!mounted) return;
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are not an authorized member of Leo Club'),
            backgroundColor: Colors.red,
          ),
        );
        // Ensure we're signed out if not authorized
        await _authService.signOut();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      // Ensure we're signed out on error
      await _authService.signOut();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFFD700), // Gold
              Color(0xFF000000), // Black
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                // Welcome text
                const Text(
                  'Welcome to\nLeoConnect!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFD700), // Gold
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 35),
                // Subtitle
                const Text(
                  'Connecting Leos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFD700), // Gold
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Empowering Change',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFD700), // Gold
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 60),
                // Description text
                const Text(
                  'Join the official LeoConnect platform to explore projects, connect with clubs across Sri Lanka, and celebrate the spirit of leadership, service, and unity under Leo Multiple District 306.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 20),
                // Google Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black87,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Google logo (using text as fallback)
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/google_icon.png',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
