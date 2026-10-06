import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

final List<Map<String, dynamic>> topics = [
  {
    'title': 'Flutter UI',
    'subtitle': 'Mengenal widget dasar Flutter',
    'status': 'Selesai',
  },
  {
    'title': 'Layout',
    'subtitle': 'Column, Row, dan Container',
    'status': 'Selesai',
  },
  {
    'title': 'State',
    'subtitle': 'StatefulWidget dan setState',
    'status': 'Berlangsung',
  },
  {
    'title': 'Input',
    'subtitle': 'TextField dan controller',
    'status': 'Berlangsung',
  },
  {
    'title': 'List',
    'subtitle': 'ListView dan data collection',
    'status': 'Belum',
  },
];

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
        appBar: AppBar(title: const Text('Tahap 10')),
        body: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),

            const SizedBox(height: 10),

            const Text(studentId, style: TextStyle(fontSize: 18)),

            const Text(
              studentName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(topic['title']),
                      subtitle: Text(topic['subtitle']),
                      trailing: Text(topic['status']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
