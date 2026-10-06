import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 4'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('$studentId - $studentName'),
              const SizedBox(height: 12),
              const Text('Flutter UI Fundamentals'),
              const SizedBox(height: 12),
              const Icon(
                Icons.flutter_dash,
                size: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}