import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblWishList = 'wishlist';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/cRestaurant.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblWishList (
          id TEXT PRIMARY KEY NOT NULL,
          name TEXT NOT NULL,
          pictureid TEXT NOT NULL,
          description TEXT NOT NULL,
          city TEXT NOT NULL,
          rating FLOAT NOT NULL)''');
    }, version: 1);

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<List<Restaurant>> getWishList() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(_tblWishList);

    return results.map((e) => Restaurant.fromMap(e)).toList();
  }

  Future<void> insertData(Restaurant data) async {
    final db = await database;

    await db!.insert(_tblWishList, data.toMap());
  }

  Future<Map> findById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(_tblWishList, where: 'id = ?', whereArgs: [id]);

    if(results.isNotEmpty){
      return results.first;
    }
    return {};
  }
}
