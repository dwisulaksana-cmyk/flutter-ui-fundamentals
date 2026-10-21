import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onExplore;

  const HomePage({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            Text(
              'Made Dwi Sulaksana',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text('NIM: 2415051047'),
            const SizedBox(height: 20),
            const Text(
              'Selamat datang di Course Explorer.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Total Course Favorit'),
                trailing: Text('${provider.favoriteCount}'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('Total Course'),
                trailing: Text('${provider.courses.length}'),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onExplore,
              icon: const Icon(Icons.menu_book),
              label: const Text('Jelajahi Course'),
            ),
          ],
        ),
      ),
    );
  }
}
