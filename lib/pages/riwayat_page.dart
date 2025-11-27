import 'package:flutter/material.dart';
import 'package:jti_reports/widgets/reports_list.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  // ============ METHOD BUILD WIDGET ============
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Riwayat Laporan',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      elevation: 4,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [_buildDaftarLaporan(context)]),
    );
  }

  Widget _buildDaftarLaporan(BuildContext context) {
    return ReportsList(
      clientSort: true,
      onCardTap: (doc) {
        navigateToDetailLaporan(context, doc);
      },
    );
  }
}
