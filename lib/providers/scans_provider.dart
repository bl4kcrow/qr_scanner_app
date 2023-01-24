import 'package:flutter/foundation.dart';
import 'package:qr_scanner_app/models/models.dart';
import 'package:qr_scanner_app/providers/providers.dart';

class ScansProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  ScanType typeSelected = ScanType.http;

  void deleteAllScans() async {
    await DatabaseProvider.instance.deleteAllScans();
    scans.clear();
    notifyListeners();
  }

  void deleteScanById(int id) async {
    await DatabaseProvider.instance.deleteScanById(id);
  }

  Future<ScanModel> newScan(String value) async {
    final scan = ScanModel(value: value);
    final id = await DatabaseProvider.instance.newScan(scan);

    scan.id = id;

    if (typeSelected == scan.type) {
      scans.add(scan);
      notifyListeners();
    }

    return scan;
  }

  void loadScansByType(ScanType type) async {
    final scansLoaded = await DatabaseProvider.instance.getScansByType(type);
    scans = [...scansLoaded];
    typeSelected = type;

    notifyListeners();
  }

  void loadScans() async {
    final scansLoaded = await DatabaseProvider.instance.getAllScans();
    scans = [...scansLoaded];

    notifyListeners();
  }
}
