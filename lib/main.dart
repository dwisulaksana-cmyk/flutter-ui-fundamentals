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
        appBar: AppBar(title: const Text('Tahap 6')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 16),
            Text(studentId, style: const TextStyle(fontSize: 18)),
            Text(
              studentName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Statistik
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Column(
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Widget'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '2',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Layout'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('State'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
