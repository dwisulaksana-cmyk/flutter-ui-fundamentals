import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

void main() {
  runApp(const CourseExplorerApp());
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

// Model data mata kuliah
class Course {
  final String code;
  final String title;
  final int credits;
  final String description;

  const Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.description,
  });
}

const List<Course> courses = [
  Course(
    code: 'PTI101',
    title: 'Pemrograman Dasar',
    credits: 3,
    description: 'Mempelajari dasar algoritma dan pemrograman.',
  ),
  Course(
    code: 'PTI102',
    title: 'Pemrograman Mobile',
    credits: 3,
    description: 'Mempelajari pengembangan aplikasi mobile dengan Flutter.',
  ),
  Course(
    code: 'PTI103',
    title: 'Basis Data',
    credits: 3,
    description: 'Mempelajari pengelolaan dan perancangan basis data.',
  ),
  Course(
    code: 'PTI104',
    title: 'Jaringan Komputer',
    credits: 2,
    description: 'Mempelajari konsep dan komunikasi jaringan komputer.',
  ),
  Course(
    code: 'PTI105',
    title: 'Rekayasa Perangkat Lunak',
    credits: 3,
    description: 'Mempelajari proses pengembangan perangkat lunak.',
  ),
  Course(
    code: 'PTI106',
    title: 'Desain UI/UX',
    credits: 2,
    description: 'Mempelajari desain antarmuka dan pengalaman pengguna.',
  ),
];

// Parent: menyimpan shared state favorit
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  // Satu sumber data favorit untuk seluruh aplikasi.
  final Set<String> favoriteCourseCodes = <String>{};

  void toggleFavorite(Course course) {
    setState(() {
      if (favoriteCourseCodes.contains(course.code)) {
        favoriteCourseCodes.remove(course.code);
      } else {
        favoriteCourseCodes.add(course.code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool expanded = constraints.maxWidth >= 840;

        final pages = [
          const HomePage(),
          CoursesPage(
            expanded: expanded,
            onOpenCourse: openCourseDetail,
            favoriteCourseCodes: favoriteCourseCodes,
            onToggleFavorite: toggleFavorite,
          ),
          const ProfilePage(),
        ];

        return Scaffold(
          appBar: AppBar(title: const Text('Course Explorer')),
          body: Row(
            children: [
              if (expanded)
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
          bottomNavigationBar: expanded
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

  void openCourseDetail(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatefulBuilder(
          builder: (context, setDetailState) {
            return CourseDetailPage(
              course: course,
              isFavorite: favoriteCourseCodes.contains(course.code),
              onToggleFavorite: () {
                toggleFavorite(course);
                setDetailState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}

// Halaman Home
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showDescription = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.school, size: 30),
                ),
                const SizedBox(height: 12),
                Text(
                  studentName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text('NIM: $studentId'),
                const SizedBox(height: 12),
                Text('Total mata kuliah: ${courses.length}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contoh Local State',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tekan tombol berikut untuk menampilkan atau '
                  'menyembunyikan penjelasan.',
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        showDescription = !showDescription;
                      });
                    },
                    icon: Icon(
                      showDescription ? Icons.visibility_off : Icons.visibility,
                    ),
                    label: Text(
                      showDescription
                          ? 'Sembunyikan Penjelasan'
                          : 'Tampilkan Penjelasan',
                    ),
                  ),
                ),
                if (showDescription) ...[
                  const Divider(),
                  const Text(
                    'showDescription merupakan local state karena '
                    'hanya digunakan oleh HomePage. Perubahannya '
                    'tidak membutuhkan Provider.',
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Identifikasi State',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        const StateInfoCard(
          title: '1. showDescription',
          type: 'Local State',
          description: 'Mengatur visibilitas penjelasan di HomePage.',
        ),
        const StateInfoCard(
          title: '2. selectedIndex',
          type: 'Local State',
          description: 'Menentukan halaman navigasi yang sedang aktif.',
        ),
        const StateInfoCard(
          title: '3. isFavorite',
          type: 'Shared State',
          description:
              'Status favorit disimpan oleh parent dan diteruskan '
              'ke kartu serta halaman detail melalui constructor '
              'dan callback.',
        ),
        const StateInfoCard(
          title: '4. isLoading',
          type: 'Local State',
          description: 'Dapat mengatur loading pada proses pengiriman form.',
        ),
        const StateInfoCard(
          title: '5. user login',
          type: 'Shared State',
          description:
              'Informasi pengguna yang login biasanya dibutuhkan oleh '
              'beberapa halaman, seperti Home dan Profile.',
        ),
      ],
    );
  }
}

// Widget informasi klasifikasi state
class StateInfoCard extends StatelessWidget {
  final String title;
  final String type;
  final String description;

  const StateInfoCard({
    super.key,
    required this.title,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          type == 'Shared State'
              ? Icons.account_tree_outlined
              : Icons.widgets_outlined,
        ),
        title: Text(title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('$type\n$description'),
        ),
        isThreeLine: true,
      ),
    );
  }
}

// Halaman daftar course
class CoursesPage extends StatelessWidget {
  final bool expanded;
  final ValueChanged<Course> onOpenCourse;
  final Set<String> favoriteCourseCodes;
  final ValueChanged<Course> onToggleFavorite;

  const CoursesPage({
    super.key,
    required this.expanded,
    required this.onOpenCourse,
    required this.favoriteCourseCodes,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth < 600
            ? 1
            : constraints.maxWidth < 840
            ? 2
            : 3;

        if (columns == 1) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];

              return CourseCard(
                course: course,
                onTap: () => onOpenCourse(course),
                isFavorite: favoriteCourseCodes.contains(course.code),
                onToggleFavorite: () => onToggleFavorite(course),
              );
            },
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];

            return CourseCard(
              course: course,
              onTap: () => onOpenCourse(course),
              isFavorite: favoriteCourseCodes.contains(course.code),
              onToggleFavorite: () => onToggleFavorite(course),
            );
          },
        );
      },
    );
  }
}

// Child: menerima state favorit dan callback dari parent.
class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_book, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      course.code,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    tooltip: isFavorite
                        ? 'Hapus dari favorit'
                        : 'Tambahkan ke favorit',
                    onPressed: () {
                      onToggleFavorite();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? 'Course dihapus dari favorit'
                                : 'Course ditambahkan ke favorit',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text('${course.credits} SKS'),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman detail menerima state dan callback dari parent.
class CourseDetailPage extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Course')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.menu_book, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    course.code,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text('Jumlah SKS: ${course.credits}'),
                  const SizedBox(height: 12),
                  Text(course.description),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: onToggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      label: Text(
                        isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Mahasiswa: $studentName'),
          Text('NIM: $studentId'),
        ],
      ),
    );
  }
}

// Halaman profil
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 40)),
        const SizedBox(height: 12),
        Text(
          studentName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text('NIM: $studentId', textAlign: TextAlign.center),
        const SizedBox(height: 24),
        Text(
          'Mengapa tidak semua state menggunakan Provider?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Tidak semua state perlu dikelola menggunakan Provider karena '
          'setiap state memiliki kebutuhan berbeda. State yang hanya '
          'digunakan oleh satu widget cukup dikelola dengan setState(). '
          'Provider lebih cocok untuk shared state yang perlu diakses '
          'oleh beberapa widget atau halaman. Dengan demikian, '
          'pengelolaan state menjadi lebih sederhana dan tidak '
          'menambah kompleksitas yang tidak diperlukan.',
        ),
      ],
    );
  }
}
