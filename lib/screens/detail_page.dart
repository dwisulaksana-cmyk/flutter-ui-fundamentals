import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class DetailPage extends StatelessWidget {
  final Course course;

  const DetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFavorite = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.menu_book, size: 80, color: Colors.indigo),
          const SizedBox(height: 24),
          Text(
            course.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Kode Course'),
                  subtitle: Text(course.code),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Jumlah SKS'),
                  subtitle: Text('${course.credits} SKS'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Status'),
                  subtitle: Text(course.status),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              title: const Text('Course Favorit'),
              subtitle: Text(
                isFavorite
                    ? 'Course ini sudah menjadi favorit.'
                    : 'Course ini belum menjadi favorit.',
              ),
              trailing: IconButton(
                tooltip: isFavorite
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                onPressed: () {
                  context.read<CourseProvider>().toggleFavorite(course.code);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
