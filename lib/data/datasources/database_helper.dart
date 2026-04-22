import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/news_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('news.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertFavorite(NewsItem item) async {
    final db = await instance.database;
    await db.insert(
      'favorites',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String id) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await instance.database;
    final maps = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }

  Future<List<NewsItem>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((json) => NewsItem.fromMap(json)).toList();
  }
}
