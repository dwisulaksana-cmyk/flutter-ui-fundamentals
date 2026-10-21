import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/course_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Center(
          child: CircleAvatar(radius: 42, child: Icon(Icons.person, size: 48)),
        ),
        const SizedBox(height: 16),
        Text(
          'Made Dwi Sulaksana',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text('NIM: 2415051047', textAlign: TextAlign.center),
        const Divider(height: 32),
        Consumer<CourseProvider>(
          builder: (context, provider, child) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Total Course Favorit'),
                trailing: Text('${provider.favoriteCount}'),
              ),
            );
          },
        ),
      ],
    );
  }
}
