import 'package:flutter_test/flutter_test.dart';
import 'package:banpang_mobile/main.dart';

void main() {
  testWidgets('Banpang smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BanpangMobileApp());
    expect(find.text('Banpang Mobile'), findsOneWidget);
  });
}
