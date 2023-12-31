import 'dart:async';
import 'package:loggy/loggy.dart';
import 'package:path/path.dart';
import 'package:prueba_tecnica_consware/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, identification TEXT, email TEXT, password TEXT)');
  }

  Future<void> addUser(User user) async {
    logInfo("ADD user to db");
    final db = await database;

    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    logInfo(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    logInfo("DELETE user to db");
    final db = await database;
    await db.delete('users', where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateUser(User user) async {
    logInfo("UPDATE user to db");
    final db = await database;
    await db.update('users', user.toJson(), where: "id = ?", whereArgs: [user.id]);
    logInfo(user.toJson());
  }

  Future<User> getUser(String email) async {
    final db = await database;
    List<Map<String, dynamic>> user =
        await db.query("users", where: "email = ?", whereArgs: [email]);
    return User.fromJson(user[0]);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> users = await db.query('users');
    return users;
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.delete('users');
  }
}