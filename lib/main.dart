import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

final List<Map<String, dynamic>> topics = [
  {
    'title': 'Flutter UI',
    'subtitle': 'Mengenal widget dasar Flutter',
    'done': true,
  },
  {'title': 'Layout', 'subtitle': 'Column, Row, dan Container', 'done': true},
  {'title': 'State', 'subtitle': 'StatefulWidget dan setState', 'done': false},
  {'title': 'Input', 'subtitle': 'TextField dan controller', 'done': false},
  {'title': 'List', 'subtitle': 'ListView dan data collection', 'done': false},
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final int completed = topics.where((item) => item['done'] == true).length;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tahap 11')),
        body: Column(
          children: [
            const SizedBox(height: 16),

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

            const SizedBox(height: 10),

            Text(
              '$completed dari ${topics.length} topik selesai',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: topics.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = topics[index];
                  final bool done = item['done'] == true;

                  return Card(
                    child: ListTile(
                      leading: Icon(done ? Icons.check_circle : Icons.schedule),
                      title: Text(item['title'] as String),
                      subtitle: Text(item['subtitle'] as String),
                      trailing: Text(done ? 'Selesai' : 'Belum'),
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
