import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    if (value.contains('http') == true) {
      type = ScanType.http;
    } else {
      type = ScanType.geo;
    }
  }

  int? id;
  ScanType? type;
  String value;

  LatLng getLatLng(){
    final latLng = value.substring(4).split(',');

    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json['id'],
        type: json['type'] == 'http' ? ScanType.http : ScanType.geo,
        value: json['value'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type?.name,
        'value': value,
      };
}

enum ScanType {
  http,
  geo,
}
