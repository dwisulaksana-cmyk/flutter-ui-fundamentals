import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseState(),
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

// MODEL COURSE

class Course {
  final String code;
  final String name;
  final String lecturer;
  final String description;
  final IconData icon;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.description,
    required this.icon,
  });
}

const List<Course> courses = [
  Course(
    code: 'PTI101',
    name: 'Pemrograman Dasar',
    lecturer: 'I Made Agus Wirawan',
    description: 'Mempelajari dasar pemrograman dan logika algoritma.',
    icon: Icons.code,
  ),
  Course(
    code: 'PTI102',
    name: 'Pengembangan Web',
    lecturer: 'Ni Luh Putu Ariestia',
    description: 'Mempelajari HTML, CSS, JavaScript, dan konsep web.',
    icon: Icons.web,
  ),
  Course(
    code: 'PTI103',
    name: 'Basis Data',
    lecturer: 'I Gede Mahendra',
    description: 'Mempelajari pengelolaan data dan query basis data.',
    icon: Icons.storage,
  ),
  Course(
    code: 'PTI104',
    name: 'Pemrograman Mobile',
    lecturer: 'I Putu Suryawan',
    description: 'Mempelajari pengembangan aplikasi mobile dengan Flutter.',
    icon: Icons.phone_android,
  ),
  Course(
    code: 'PTI105',
    name: 'Desain Antarmuka',
    lecturer: 'Ni Made Pradnyani',
    description: 'Mempelajari desain UI dan pengalaman pengguna.',
    icon: Icons.design_services,
  ),
  Course(
    code: 'PTI106',
    name: 'Jaringan Komputer',
    lecturer: 'I Wayan Aditya',
    description: 'Mempelajari konsep jaringan komputer.',
    icon: Icons.lan,
  ),
];

// RESPONSIVE SHELL

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
      HomePage(
        onExplore: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),
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
                    setState(() {
                      selectedIndex = index;
                    });
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
                    setState(() {
                      selectedIndex = index;
                    });
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

// HOME PAGE

class HomePage extends StatelessWidget {
  final VoidCallback onExplore;

  const HomePage({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

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
                trailing: Text(
                  '${courseState.favoriteCount}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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

// COURSES PAGE

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Daftar Course', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...courses.map(
          (course) => CourseCard(
            course: course,
            isFavorite: courseState.isFavorite(course.code),
            onFavoriteChanged: () {
              context.read<CourseState>().toggleFavorite(course.code);
            },
          ),
        ),
      ],
    );
  }
}

// COURSE CARD

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
        leading: CircleAvatar(child: Icon(course.icon)),
        title: Text(course.name),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${course.code}\n'
            'Dosen: ${course.lecturer}\n'
            '${course.description}',
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

// PROFILE PAGE

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CourseState>();

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
        ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: const Text('Total Course Favorit'),
          trailing: Text(
            '${courseState.favoriteCount}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
