import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/deichman_bok.dart';

class DatabaseHelper {
  static const _databaseName = 'books_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        recordId TEXT NOT NULL,
        title TEXT NOT NULL,
        mediaType TEXT,
        author TEXT,
        publishedYear INTEGER,
        coverImage TEXT,
        plot TEXT
      )
    ''');
  }

  Future<int> insert(DeichmanBok book) async {
    Database db = await instance.database;
    return await db.insert(_tableName, book.toJson());
  }

  Future<List<DeichmanBok>> readAllBooks() async {
    Database db = await instance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty
        ? books
            .map((bookData) => DeichmanBok.fromJsonDatabase(bookData))
            .toList()
        : [];
  }

  Future<int> deleteBook(String id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'recordId = ?', whereArgs: [id]);
  }
}
