import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jti_reports/core/widgets/loading_button.dart';
import 'package:jti_reports/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group(
    'Test Tambah Laporan',
    () {
      testWidgets(
        '[A] Berhasil tambah laporan dengan data valid',
        (tester) async {
          print("Mulai Test A - Input Valid");
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(TextButton).at(0));
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'afriansyy@gmail.com');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'Afriansyah12');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(LoadingButton).at(0));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.byIcon(Icons.add_circle_outline).first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(0), 'Integration Testing');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'LKJ3-LT7B');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(2), 'Ini adalah laporan dari integration testing.');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(DropdownButton<String>).first);
          await tester.pumpAndSettle();
          await tester.tap(find.text('Rendah').last);
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('Laporan berhasil dikirim'), findsOneWidget);
          print("Test A Selesai");
        },
      );

      testWidgets(
        '[B] Gagal tambah laporan tanpa input data',
        (tester) async {
          print("Mulai Test B - Tanpa Input Data");
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byIcon(Icons.add_circle_outline).first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(0), '');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), '');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(2), '');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(DropdownButton<String>).first);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text("Tingkat Keparahan"));
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(
            find.byWidgetPredicate((widget) =>
              widget is SnackBar &&
              (widget.content is Text) &&
              (
                (widget.content as Text).data == 'Jenis kerusakan harus diisi' ||
                (widget.content as Text).data == 'Lokasi fasilitas harus diisi' ||
                (widget.content as Text).data == 'Deskripsi kerusakan harus diisi' ||
                (widget.content as Text).data == 'Tingkat keparahan harus dipilih'
              )
            ),
            findsOneWidget,
          );
          print("Test B Selesai");
        },
      );
    },
  );
}
