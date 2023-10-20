import 'dart:async';
import 'package:loggy/loggy.dart';
import 'package:path/path.dart';
import 'package:prueba_tecnica_consware/data/models/credito.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

class CotizacionLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'creditos___database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE creditos (id INTEGER PRIMARY KEY AUTOINCREMENT, tipoCredito TEXT, salarioBase TEXT, maximoPrestamo TEXT,cuotaCredito TEXT, anualInterest TEXT, term TEXT, email TEXT, fecha TEXT)');
  }

  Future<void> addCotizacion(Credito credito) async {
    logInfo("ADD credito to db");
    final db = await database;

    await db.insert(
      'creditos',
      credito.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    logInfo(credito.toJson());
  }

  Future<Credito> getCotizacion(int id) async {
    final db = await database;
    List<Map<String, dynamic>> cotizacion =
        await db.query("creditos", where: "id = ?", whereArgs: [id]);
    logDebug(cotizacion);
    return Credito.fromJson(cotizacion[0]);
  }

  Future<List<Map<String, dynamic>>> getAllCotizacionesByUser(
      String email) async {
    final db = await database;
    final List<Map<String, dynamic>> cotizaciones = await db.query('creditos');
    return cotizaciones;
    //return cotizaciones.where((cotizacion) => cotizacion['email'] == email).toList();
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.delete('cotizaciones');
  }
}
