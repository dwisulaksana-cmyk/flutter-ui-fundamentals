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
      title: 'Tahap 12',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CoursePage(),
    );
  }
}

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  final List<Map<String, dynamic>> courses = const [
    {'code': 'PTI101', 'title': 'Pemrograman Dasar', 'credits': 3},
    {'code': 'PTI102', 'title': 'Pemrograman Mobile', 'credits': 3},
    {'code': 'PTI103', 'title': 'Basis Data', 'credits': 3},
    {'code': 'PTI104', 'title': 'Jaringan Komputer', 'credits': 3},
    {'code': 'PTI105', 'title': 'Rekayasa Perangkat Lunak', 'credits': 3},
    {'code': 'PTI106', 'title': 'Desain UI/UX', 'credits': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            studentName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(studentId, style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),

          ...courses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CourseCard(course: course),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  void showCourseInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.course['title']} - ${widget.course['credits']} SKS',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: showCourseInfo,
      child: Card(
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${widget.course['title']} dipilih')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  child: Text(widget.course['code'].substring(3)),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course['title'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${widget.course['code']} • '
                        '${widget.course['credits']} SKS',
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tap untuk memilih • Long press untuk info',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  tooltip: 'Favorite',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
