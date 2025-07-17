import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utilidades/src/models/person_model.dart';

class SqliteService {

  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB('app.db');
    return _db!;
  }

  Future<Database> _initDB(String name) async {
    final path = join(await getDatabasesPath(), name);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
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
      final database = await db;
      return database.insert("pessoas", person.toMap());
    }

  Future<List<PersonModel>> getAllPersons() async {
    final database = await db;
    final result = await database.query('pessoas');
    return result.map((e) => PersonMode.
  }
}
