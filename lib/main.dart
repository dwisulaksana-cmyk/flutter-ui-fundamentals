import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

void main() {
  runApp(const DebuggingChallengeApp());
}

class DebuggingChallengeApp extends StatelessWidget {
  const DebuggingChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debugging Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DebuggingHomePage(),
    );
  }
}

class DebuggingHomePage extends StatefulWidget {
  const DebuggingHomePage({super.key});

  @override
  State<DebuggingHomePage> createState() => _DebuggingHomePageState();
}

class _DebuggingHomePageState extends State<DebuggingHomePage> {
  int selectedCase = 0;

  final List<String> caseTitles = [
    'Kasus A - Row Overflow',
    'Kasus B - ListView',
    'Kasus C - Keyboard',
    'Kasus D - Navigasi Ganda',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 16 - Debugging Challenge')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text('NIM: $studentId'),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: List.generate(
                caseTitles.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(caseTitles[index]),
                    selected: selectedCase == index,
                    onSelected: (_) {
                      setState(() {
                        selectedCase = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),

          const Divider(),

          Expanded(child: _buildSelectedCase()),
        ],
      ),
    );
  }

  Widget _buildSelectedCase() {
    switch (selectedCase) {
      case 0:
        return const CaseA();
      case 1:
        return const CaseB();
      case 2:
        return const CaseC();
      case 3:
        return const CaseD();
      default:
        return const CaseA();
    }
  }
}

// ============================================================
// KASUS A
// ============================================================

class CaseA extends StatelessWidget {
  const CaseA({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus A - RenderFlex Overflow',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Solusi menggunakan Expanded.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info),
              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  '$studentId - $studentName - teks sangat panjang yang '
                  'digunakan untuk menguji masalah RenderFlex overflow '
                  'pada Row ketika ruang horizontal terbatas.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text('Solusi:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          const Text(
            'Text dibungkus dengan Expanded sehingga Text hanya menggunakan '
            'ruang horizontal yang tersedia. Jika teks lebih panjang dari '
            'lebar layar, teks akan turun ke baris berikutnya sehingga tidak '
            'keluar dari batas Row.',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KASUS B
// ============================================================

class CaseB extends StatelessWidget {
  const CaseB({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(10, (index) => 'Item ${index + 1}');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus B - Vertical Viewport',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'ListView harus memiliki batas tinggi ketika berada di dalam Column.',
          ),
          const SizedBox(height: 12),

          // Solusi: Expanded memberikan batas tinggi kepada ListView.
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(items[index]),
                    subtitle: const Text(
                      'ListView dengan tinggi yang terkontrol',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KASUS C
// ============================================================

class CaseC extends StatelessWidget {
  const CaseC({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus C - Keyboard Overflow',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          const Text(
            'Buka keyboard dan coba isi form. Halaman tetap dapat digulir.',
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextFormField(
            decoration: const InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Komentar',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextFormField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Deskripsi',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form berhasil diproses')),
                );
              },
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KASUS D
// ============================================================

class CaseD extends StatefulWidget {
  const CaseD({super.key});

  @override
  State<CaseD> createState() => _CaseDState();
}

class _CaseDState extends State<CaseD> {
  bool isNavigating = false;

  Future<void> openDetail() async {
    // Mencegah tombol ditekan berkali-kali sebelum route selesai.
    if (isNavigating) return;

    setState(() {
      isNavigating = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NavigationDetailPage()),
    );

    if (!mounted) return;

    setState(() {
      isNavigating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus D - Navigasi Ganda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          const Text(
            'Tombol dibuat disabled ketika proses navigasi sedang berlangsung '
            'agar pengguna tidak melakukan push route berkali-kali.',
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isNavigating ? null : openDetail,
              icon: const Icon(Icons.open_in_new),
              label: Text(isNavigating ? 'Membuka halaman...' : 'Buka Detail'),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Pada aplikasi nyata, aksi ganda dapat dicegah dengan membuat '
            'state loading/processing, menonaktifkan tombol sementara, '
            'atau memastikan aksi hanya diproses satu kali.',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DETAIL NAVIGASI
// ============================================================

class NavigationDetailPage extends StatelessWidget {
  const NavigationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Detail')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, size: 70),
              const SizedBox(height: 16),
              const Text(
                'Route berhasil dibuka.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '$studentName\nNIM: $studentId',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
