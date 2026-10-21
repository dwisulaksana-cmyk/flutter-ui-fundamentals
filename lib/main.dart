import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';
import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          CourseProvider(CourseRepository(CourseService()))..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onExplore: () => setState(() => selectedIndex = 1)),
      const CoursesPage(),
      const ProfilePage(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(title: const Text('Course Explorer')),
          body: Row(
            children: [
              if (isWide)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
              Expanded(
                child: IndexedStack(index: selectedIndex, children: pages),
              ),
            ],
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

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

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

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

    if (provider.courses.isEmpty) {
      return const Center(child: Text('Belum ada data course.'));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Daftar Course', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text('Data dikelola oleh CourseProvider.'),
        const SizedBox(height: 12),
        ...provider.courses.map(
          (course) => CourseCard(
            course: course,
            isFavorite: provider.isFavorite(course.code),
            onFavoriteChanged: () {
              context.read<CourseProvider>().toggleFavorite(course.code);
            },
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(child: Text(course.code.replaceAll('PTI', ''))),
        title: Text(course.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'Kode: ${course.code}\n'
            'SKS: ${course.credits}\n'
            'Status: ${course.status}',
          ),
        ),
        isThreeLine: true,
        trailing: IconButton(
          tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambahkan ke favorit',
          onPressed: onFavoriteChanged,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

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
          builder: (context, state, child) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Total Course Favorit'),
                trailing: Text('${state.favoriteCount}'),
              ),
            );
          },
        ),
      ],
    );
  }
}
