import 'package:flutter_test/flutter_test.dart';
import 'package:bara_2_babi/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const BaraDeBabiApp());
    // Verify the splash screen is shown
    expect(find.text('BARRA DE BABI'), findsOneWidget);
  });
}
