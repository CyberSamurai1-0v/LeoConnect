import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
             begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD700), // Gold 
              Color(0xFF000000), // Black 
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top text
              const Text(
                'Leadership \n Experience \n Opportunity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // LEO Logo
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leo_icon.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Bottom text
              const Column(
                children: [
                  Text(
                    'LeoConnect \n Sri Lanka',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
