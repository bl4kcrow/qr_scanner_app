import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_app/models/models.dart';
import 'package:qr_scanner_app/providers/providers.dart';
import 'package:qr_scanner_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded),
            onPressed: () {
              Provider.of<ScansProvider>(
                context,
                listen: false,
              ).deleteAllScans();
            },
          ),
        ],
        centerTitle: true,
        title: const Text('History'),
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final scansProvider = Provider.of<ScansProvider>(
      context,
      listen: false,
    );
    final currentIndex = uiProvider.selectedMenuOption;

    switch (currentIndex) {
      case 0:
        scansProvider.loadScansByType(ScanType.geo);
        break;
      case 1:
        scansProvider.loadScansByType(ScanType.http);
        break;
      default:
        scansProvider.loadScansByType(ScanType.geo);
    }

    return const ScanTiles();
  }
}
