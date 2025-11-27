import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screens/loading_screen.dart';
import 'screens/login_screens/login_screen.dart';
import 'screens/login_screens/login_details.dart';
import 'screens/contact_us.dart';

import 'config/colors.dart';
import './screens/Member/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeoConnect Sri Lanka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700),
          brightness: Brightness.dark,
        ),
      ),
      home: const LoadingScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/login-details': (context) => const LoginDetails(),
        '/contact_us': (context) => const ContactUs(),
      },
    );
  }
}

// Keeping the original HomePage for future use
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Home()),
                );
              },
              child: const Text('Go to Member Directory'),
            ),
          ],
        ),
      ),
    );
  }
}
