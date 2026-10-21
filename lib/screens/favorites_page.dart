import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              const Text(
                'Terjadi kesalahan saat memuat course.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(provider.error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  context.read<CourseProvider>().loadCourses();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    final favoriteCourses = provider.favoriteCourses;

    if (favoriteCourses.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'Belum ada course favorit.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Tambahkan course ke favorit dari halaman Courses.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Course Favorit',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text('Total favorit: ${provider.favoriteCount}'),
        const SizedBox(height: 12),
        ...favoriteCourses.map(
          (course) => CourseCard(
            course: course,
            isFavorite: provider.isFavorite(course.code),
            onFavoriteChanged: () {
              context.read<CourseProvider>().toggleFavorite(course.code);
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(course: course)),
              );
            },
          ),
        ),
      ],
    );
  }
}
