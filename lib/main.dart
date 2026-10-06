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
      title: 'Tahap 5',
      home: const CoursePage(),
    );
  }
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  final List<Map<String, String>> courses = const [
    {
      'code': 'PTI101',
      'name': 'Pemrograman Dasar',
      'description': 'Dasar-dasar pemrograman dan algoritma.',
    },
    {
      'code': 'PTI102',
      'name': 'Pemrograman Mobile',
      'description': 'Pengembangan aplikasi mobile menggunakan Flutter.',
    },
    {
      'code': 'PTI103',
      'name': 'Basis Data',
      'description': 'Konsep dan pengelolaan basis data.',
    },
    {
      'code': 'PTI104',
      'name': 'Jaringan Komputer',
      'description': 'Dasar jaringan dan komunikasi komputer.',
    },
    {
      'code': 'PTI105',
      'name': 'Rekayasa Perangkat Lunak',
      'description': 'Analisis dan pengembangan perangkat lunak.',
    },
    {
      'code': 'PTI106',
      'name': 'Desain UI/UX',
      'description': 'Perancangan antarmuka dan pengalaman pengguna.',
    },
  ];

  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5 - GridView Responsif')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = columnsFor(constraints.maxWidth);

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(studentId, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(course: courses[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, String> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.menu_book, size: 40),
            const SizedBox(height: 10),
            Text(
              course['code']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              course['name']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(course['description']!),
          ],
        ),
      ),
    );
  }
}
