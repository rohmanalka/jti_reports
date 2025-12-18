import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jti_reports/core/widgets/loading_button.dart';
import 'package:jti_reports/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Test Update Laporan',
    () {
      testWidgets(
        '[A] Berhasil update laporan',
        (tester) async {
          print("Mulai Test A - Update Laporan");
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

          await tester.tap(find.byIcon(Icons.history).first);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.text('Integration Testing').first);
          await tester.pumpAndSettle();
          if (find.byType(Scrollable).evaluate().isNotEmpty) {
            await tester.fling(find.byType(Scrollable).first, const Offset(0, -1000), 1200);
            await tester.pumpAndSettle();
          } else if (find.byType(SingleChildScrollView).evaluate().isNotEmpty) {
            await tester.fling(find.byType(SingleChildScrollView).first, const Offset(0, -1000), 1200);
            await tester.pumpAndSettle();
          }
          await Future.delayed(const Duration(seconds: 2));
          if (find.byIcon(Icons.edit).evaluate().isNotEmpty) {
            await tester.tap(find.byIcon(Icons.edit).first);
          } else if (find.text('Update').evaluate().isNotEmpty) {
            await tester.tap(find.text('Update').first);
          } else {
            await tester.tap(find.byType(ElevatedButton).first);
          }
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(0), 'Integration Testing - Updated');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(1), 'LKJ3-LT7B-UPDATED');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextField).at(2), 'Update: ini adalah perubahan dari integration testing.');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(DropdownButton<String>).first);
          await tester.pumpAndSettle();
          await tester.tap(find.text('Rendah').last);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          if (find.textContaining('Simpan Perubahan').evaluate().isNotEmpty) {
            await tester.tap(find.textContaining('Simpan Perubahan').first);
          } else {
            await tester.tap(find.byType(ElevatedButton).first);
          }
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('Laporan berhasil diperbarui'), findsOneWidget);
          print("Test A Selesai");
        },
      );

      testWidgets(
        '[B] Gagal update laporan',
        (tester) async {
          print("Mulai Test B - Update Laporan");
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.byIcon(Icons.history).first);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.text('Integration Testing').first);
          await tester.pumpAndSettle();
          if (find.byType(Scrollable).evaluate().isNotEmpty) {
            await tester.fling(find.byType(Scrollable).first, const Offset(0, -1000), 1200);
            await tester.pumpAndSettle();
          } else if (find.byType(SingleChildScrollView).evaluate().isNotEmpty) {
            await tester.fling(find.byType(SingleChildScrollView).first, const Offset(0, -1000), 1200);
            await tester.pumpAndSettle();
          }
          await Future.delayed(const Duration(seconds: 2));
          if (find.byIcon(Icons.edit).evaluate().isNotEmpty) {
            await tester.tap(find.byIcon(Icons.edit).first);
          } else if (find.text('Update').evaluate().isNotEmpty) {
            await tester.tap(find.text('Update').first);
          } else {
            await tester.tap(find.byType(ElevatedButton).first);
          }
          await tester.pumpAndSettle();
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
          if (find.textContaining('Simpan Perubahan').evaluate().isNotEmpty) {
            await tester.tap(find.textContaining('Simpan Perubahan').first);
          } else {
            await tester.tap(find.byType(ElevatedButton).first);
          }
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
