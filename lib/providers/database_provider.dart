import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner_app/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static Database? _database;
  static final DatabaseProvider instance = DatabaseProvider._();

  Future<Database?> get database async {
    _database ??= await initDatabase();

    return _database;
  }

  Future<int> deleteAllScans() async {
    final db = await database;

    final result = await db?.delete('Scans');

    return result ?? 0;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;

    final result = await db?.delete(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result ?? 0;
  }

  Future<List<ScanModel>> getAllScans() async {
    final allScans = <ScanModel>[];
    final db = await database;

    final result = await db?.query('Scans');

    result?.forEach(
      (scan) => allScans.add(
        ScanModel.fromMap(scan),
      ),
    );

    return allScans;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    ScanModel? scanModel;

    final result = await db?.query(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result != null) {
      scanModel = ScanModel.fromMap(result.first);
    }

    return scanModel;
  }

  Future<List<ScanModel>> getScansByType(ScanType type) async {
    final scansByType = <ScanModel>[];
    final db = await database;

    final result = await db?.query(
      'Scans',
      where: 'type = ?',
      whereArgs: [type.name],
    );

    result?.forEach(
      (scan) => scansByType.add(
        ScanModel.fromMap(scan),
      ),
    );

    return scansByType;
  }

  Future<Database?> initDatabase() async {
    // Get the path where is de DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    debugPrint(path);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (
        db,
        version,
      ) async {
        await db.execute(
          '''CREATE TABLE Scans (
              id INTEGER PRIMARY KEY, 
              type TEXT, 
              value INTEGER)''',
        );
      },
    );

    return database;
  }

  Future<int> newScan(ScanModel scanModel) async {
    final db = await database;

    final result = await db?.insert(
      'Scans',
      scanModel.toMap(),
    );

    return result ?? 0;
  }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;

    final result = await db?.update(
      'Scans',
      newScan.toMap(),
      where: 'id = ?',
      whereArgs: [newScan.id],
    );

    return result ?? 0;
  }
}
