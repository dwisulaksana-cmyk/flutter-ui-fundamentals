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
        appBar: AppBar(title: const Text('Tahap 4 - Layout')),
        body: const Padding(padding: EdgeInsets.all(16), child: Tahap4()),
      ),
    );
  }
}

class Tahap4 extends StatelessWidget {
  const Tahap4({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      'Flutter',
      'Dart',
      'UI Design',
      'Git',
      'Firebase',
      'Android',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            studentName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(studentId),

          const SizedBox(height: 24),

          const Text(
            'Expanded 2:1',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(flex: 2, child: buildBox('A')),
              const SizedBox(width: 8),
              Expanded(child: buildBox('B')),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Flexible',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Flexible(
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Flexible menyesuaikan ruang yang tersedia.',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.phone_android, size: 45),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Wrap - Skills',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Chip(label: Text(skill))).toList(),
          ),

          const SizedBox(height: 24),

          const Text(
            'Perbandingan dengan Row',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Row biasa tetap menyusun child dalam satu baris sehingga '
            'dapat mengalami overflow ketika ruang tidak cukup. '
            'Wrap akan memindahkan child ke baris berikutnya.',
          ),
        ],
      ),
    );
  }

  static Widget buildBox(String text) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
