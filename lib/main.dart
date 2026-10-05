import 'package:flutter/material.dart';

void main() {
  const studentName = 'Made Dwi Sulaksana';
  const studentId = '2415051047';

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter UI Fundamentals'),
        ),
        body: Center(
          child: Text('$studentId - $studentName'),
        ),
      ),
    ),
  );
}