import 'dart:async';
import 'package:flutter/material.dart';
import 'package:slayan/view/utility/on_board.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunggu selama 3 detik dan kemudian navigasi ke halaman OnBoardingScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const OnBoardingScreen()), // Pastikan nama class sesuai
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Logo (Tengah)
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/splash_logo_slayan.png',
                width: 160,
                height: 160,
              ),
            ),
          ),
          // Teks Powered by dan TeraDev (Bawah)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4), // Jarak antara Powered by dan TeraDev
                Text(
                  'TeraDev',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
