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
      title: 'Tahap 8',
      home: const CoursePage(),
    );
  }
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  final List<Map<String, dynamic>> courses = const [
    {
      'code': 'PTI101',
      'title': 'Pemrograman Dasar',
      'credits': 3,
      'status': 'Lulus',
    },
    {
      'code': 'PTI102',
      'title': 'Pemrograman Mobile',
      'credits': 3,
      'status': 'Berlangsung',
    },
    {'code': 'PTI103', 'title': 'Basis Data', 'credits': 3, 'status': 'Lulus'},
    {
      'code': 'PTI104',
      'title': 'Jaringan Komputer',
      'credits': 3,
      'status': 'Berlangsung',
    },
    {
      'code': 'PTI105',
      'title': 'Rekayasa Perangkat Lunak',
      'credits': 3,
      'status': 'Berlangsung',
    },
    {
      'code': 'PTI106',
      'title': 'Desain UI/UX',
      'credits': 2,
      'status': 'Lulus',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mata Kuliah')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(child: Text(course['code'].substring(3))),
              title: Text(
                course['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${course['code']} • ${course['credits']} SKS • ${course['status']}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailPage(course: course),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mata Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              studentName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(studentId, style: TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            const Text(
              'Informasi Mata Kuliah',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(
              course['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text('Kode: ${course['code']}'),
            const SizedBox(height: 8),
            Text('SKS: ${course['credits']}'),
            const SizedBox(height: 8),
            Text('Status: ${course['status']}'),
          ],
        ),
      ),
    );
  }
}
