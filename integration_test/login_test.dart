import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jti_reports/core/widgets/loading_button.dart';
import 'package:jti_reports/main.dart' as app;
import 'package:jti_reports/features/home/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Test Login',
    () {
      testWidgets(
        '[A] Berhasil login dengan data valid',
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
          expect(find.byType(HomePage), findsOneWidget);
          print("Test A Selesai");
          await FirebaseAuth.instance.signOut();
        },
      );

      testWidgets(
        '[B] Gagal login dengan data tidak valid',
        (tester) async {
          print("Mulai Test B - Input Tidak Valid");
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(TextButton).at(0));
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'wrongemail@gmail.com');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'incorrectpassword');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(LoadingButton).at(0));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('The supplied auth credential is incorrect, malformed or has expired.'), findsOneWidget);
          print("Test B Selesai");
        },
      );
    },
  );
}