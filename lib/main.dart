import 'package:flutter/material.dart';

const String studentName = 'Made Dwi Sulaksana';
const String studentId = '2415051047';

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  final TextEditingController controller = TextEditingController();

  String message = 'Belum ada pesan';

  void tampilkanPesan() {
    setState(() {
      final input = controller.text.trim();

      message = input.isEmpty ? 'Input masih kosong' : 'Halo, $input!';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Masukkan nama untuk menampilkan sapaan:',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nama',
            hintText: 'Masukkan nama kamu',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        ElevatedButton(
          onPressed: tampilkanPesan,
          child: const Text('Tampilkan'),
        ),

        const SizedBox(height: 16),

        Text(
          message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tahap 9')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),

              const SizedBox(height: 16),

              const Text(studentId, style: TextStyle(fontSize: 18)),

              const Text(
                studentName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              const GreetingCard(),
            ],
          ),
        ),
      ),
    );
  }
}
