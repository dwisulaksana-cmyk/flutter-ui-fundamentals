import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

void main() {
  runApp(const CourseExplorerApp());
}

// ======================================================
// APP
// ======================================================

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// ======================================================
// DATA COURSE
// ======================================================

const List<Map<String, dynamic>> courses = [
  {
    'code': 'PTI101',
    'title': 'Pemrograman Dasar',
    'credits': 3,
    'description': 'Mempelajari konsep dasar algoritma dan pemrograman.',
  },
  {
    'code': 'PTI102',
    'title': 'Pemrograman Mobile',
    'credits': 3,
    'description': 'Mempelajari pengembangan aplikasi mobile menggunakan Flutter dan Dart.',
  },
  {
    'code': 'PTI103',
    'title': 'Basis Data',
    'credits': 3,
    'description': 'Mempelajari konsep database, tabel, relasi, query, dan pengelolaan data.',
  },
  {
    'code': 'PTI104',
    'title': 'Jaringan Komputer',
    'credits': 3,
    'description': 'Mempelajari konsep jaringan komputer dan komunikasi data.',
  },
  {
    'code': 'PTI105',
    'title': 'Rekayasa Perangkat Lunak',
    'credits': 3,
    'description': 'Mempelajari proses pengembangan perangkat lunak.',
  },
  {
    'code': 'PTI106',
    'title': 'Desain UI/UX',
    'credits': 2,
    'description': 'Mempelajari desain antarmuka dan pengalaman pengguna.',
  },
];

// ======================================================
// RESPONSIVE SHELL
// ======================================================

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [HomePage(), CoursesPage(), ProfilePage()];

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 840;

        // COMPACT & MEDIUM
        if (!isExpanded) {
          return Scaffold(
            body: pages[selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: changePage,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
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
        }

        // EXPANDED
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: changePage,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(Icons.school),
                    label: Text('Courses'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[selectedIndex]),
            ],
          ),
        );
      },
    );
  }
}

// ======================================================
// HOME PAGE
// ======================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Selamat Datang',
              subtitle: 'Explore your courses',
            ),

            const SizedBox(height: 24),

            // IDENTITAS
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.person, size: 38),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            studentName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(studentId),
                          SizedBox(height: 4),
                          Text('Pendidikan Teknik Informatika'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Course Explorer merupakan aplikasi sederhana '
              'untuk melihat daftar mata kuliah secara responsif '
              'sesuai ukuran layar.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 24),

            const SectionTitle(
              title: 'Total Course',
              subtitle: 'Available courses',
            ),

            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.school)),
                title: const Text(
                  '6 Mata Kuliah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Pilih menu Courses untuk melihat detail.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// COURSES PAGE
// ======================================================

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // COMPACT
          // < 600 px = 1 kolom/list
          if (constraints.maxWidth < 600) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                return CourseCard(course: courses[index]);
              },
            );
          }

          // MEDIUM = 2 kolom
          // EXPANDED = 3 kolom
          final int columns = constraints.maxWidth < 840 ? 2 : 3;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              return CourseCard(course: courses[index]);
            },
          );
        },
      ),
    );
  }
}

// ======================================================
// COURSE CARD
// ======================================================

class CourseCard extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  Future<void> openDetail() async {
    final bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CourseDetailPage(course: widget.course);
        },
      ),
    );

    if (!mounted) {
      return;
    }

    if (result == true) {
      setState(() {
        isFavorite = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.course['title']} ditambahkan ke favorite.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: openDetail,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(widget.course['code'].toString().substring(3)),
                  ),
                  const Spacer(),
                  Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                widget.course['title'].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${widget.course['code']} • '
                '${widget.course['credits']} SKS',
              ),

              const SizedBox(height: 12),

              const Text(
                'Tap untuk melihat detail',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// COURSE DETAIL PAGE
// ======================================================

class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Course ditambahkan ke favorite.'
              : 'Course dihapus dari favorite.',
        ),
      ),
    );
  }

  void goBack() {
    Navigator.pop(context, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              studentName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            const Text(studentId),

            const SizedBox(height: 30),

            CircleAvatar(
              radius: 35,
              child: Text(widget.course['code'].toString().substring(3)),
            ),

            const SizedBox(height: 20),

            Text(
              widget.course['title'].toString(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text('Kode: ${widget.course['code']}'),

            Text('SKS: ${widget.course['credits']}'),

            const SizedBox(height: 20),

            Text(
              widget.course['description'].toString(),
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: toggleFavorite,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(
                  isFavorite ? 'Hapus dari Favorite' : 'Tambah Favorite',
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: goBack,
                child: const Text('Kembali ke Courses'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// PROFILE PAGE
// ======================================================

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    final FormState? formState = formKey.currentState;

    if (formState == null) {
      return;
    }

    if (!formState.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin mengirim feedback?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feedback berhasil dikirim!')),
                );

                commentController.clear();
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 50),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  studentName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 4),

              const Center(
                child: Text(studentId, style: TextStyle(fontSize: 17)),
              ),

              const SizedBox(height: 4),

              const Center(child: Text('Pendidikan Teknik Informatika')),

              const SizedBox(height: 32),

              const SectionTitle(
                title: 'Feedback',
                subtitle: 'Berikan komentar tentang aplikasi',
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  hintText: 'Minimal 5 karakter',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }

                  if (value.trim().length < 5) {
                    return 'Komentar minimal 5 karakter';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: submitFeedback,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// REUSABLE SECTION TITLE
// ======================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }
}
