import 'package:flutter/material.dart';
import 'package:jti_reports/core/widgets/appbar/main_app_bar_admin.dart';
import 'package:jti_reports/features/admin/widgets/admin_reports_list.dart';

class AdminRiwayatPage extends StatelessWidget {
  final void Function(int index) onTabChange;

  const AdminRiwayatPage({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarAdmin(title: 'Riwayat Laporan (Admin)'),
      backgroundColor: Colors.indigo[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Expanded(child: AdminReportsList()),
          ],
        ),
      ),
    );
  }
}
