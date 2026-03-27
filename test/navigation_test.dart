import 'package:flutter_test/flutter_test.dart';
import 'package:bara_2_babi/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BaraDeBabiApp());
    await tester.pump();
    // App should start with splash screen
    expect(find.text('BARRA DE BABI'), findsOneWidget);
  });
}
