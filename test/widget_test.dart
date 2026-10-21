import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/main.dart';

void main() {
  testWidgets('Course Explorer menampilkan halaman utama', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ResponsiveShell());

    expect(find.text('Course Explorer'), findsWidgets);
  });
}
