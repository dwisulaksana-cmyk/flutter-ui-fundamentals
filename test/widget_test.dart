import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/course_provider.dart';
import 'package:flutter_ui_fundamentals/main.dart';
import 'package:flutter_ui_fundamentals/repositories/course_repository.dart';
import 'package:flutter_ui_fundamentals/services/course_service.dart';

void main() {
  testWidgets('Course Explorer menampilkan identitas mahasiswa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CourseProvider(CourseRepository(CourseService())),
        child: const CourseExplorerApp(),
      ),
    );

    expect(find.text('Course Explorer'), findsOneWidget);
    expect(find.text('Made Dwi Sulaksana'), findsOneWidget);
    expect(find.text('NIM: 2415051047'), findsOneWidget);
  });
}
