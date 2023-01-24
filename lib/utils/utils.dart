import 'package:flutter/material.dart';
import 'package:qr_scanner_app/models/models.dart';
import 'package:url_launcher/url_launcher_string.dart';

void launchInWebViewOrVC({
  required BuildContext context,
  required ScanModel scan,
}) async {
  if (scan.type == ScanType.http) {
    if (!await launchUrlString(
      scan.value,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch ${scan.value}');
    }
  } else {
    Navigator.pushNamed(
      context,
      'map',
      arguments: scan,
    );
  }
}
