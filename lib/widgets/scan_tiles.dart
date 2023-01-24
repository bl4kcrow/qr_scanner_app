import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_app/models/models.dart';
import 'package:qr_scanner_app/providers/providers.dart';
import 'package:qr_scanner_app/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final scansProvider = Provider.of<ScansProvider>(context);
    final scans = scansProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red.shade300,
          ),
        ),
        key: UniqueKey(),
        onDismissed: (_) {
          Provider.of<ScansProvider>(
            context,
            listen: false,
          ).deleteScanById(scans[index].id!);
        },
        child: ListTile(
          leading: scansProvider.typeSelected == ScanType.http
              ? const Icon(Icons.link_outlined)
              : const Icon(Icons.place_rounded),
          onTap: () => launchInWebViewOrVC(
            context: context,
            scan: scans[index],
          ),
          subtitle: Text(scans[index].id.toString()),
          title: Text(scans[index].value),
        ),
      ),
    );
  }
}
