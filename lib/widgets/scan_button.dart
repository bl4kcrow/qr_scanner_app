import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_app/providers/providers.dart';
import 'package:qr_scanner_app/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScansProvider>(
      context,
      listen: false,
    );

    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF',
          'Cancel',
          false,
          ScanMode.QR,
        );

        // String barcodeScanRes = 'https://bl4kcrow.github.io';
        // String barcodeScanRes = 'geo:19.33267057260250, -99.1920771799439';

        if (barcodeScanRes != '-1') {
          final newScan = await scansProvider.newScan(barcodeScanRes);
          launchInWebViewOrVC(
            context: context,
            scan: newScan,
          );
          debugPrint('SCAN RESULT: $barcodeScanRes');
        }
      },
      child: const Icon(
        Icons.filter_center_focus_rounded,
      ),
    );
  }
}
