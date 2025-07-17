import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utilidades/src/models/person_model.dart';

class SqliteService {
  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB('app.db');
    return _db!;
  }

  Future<Database> _initDB(String name) async {
    final path = join(await getDatabasesPath(), name);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pessoas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertPerson(PersonModel person) async {
    final db = await database; 
    return await db.insert('pessoas', person.toMap());
  }

  Future<List<PersonModel>> getAllPersons() async {
    final db = await database;
    final result = await db.query('pessoas');
    return result.map((map) => PersonModel.fromMap(map)).toList();
  }

  Future<void> deletePerson(int id) async {
    final db = await database;
    await db.delete('pessoas', where: 'id = ?', whereArgs: [id]);
  }
}
