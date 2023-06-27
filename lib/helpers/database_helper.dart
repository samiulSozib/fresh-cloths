import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cart_model.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items(
        id INTEGER PRIMARY KEY,
        name TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
  }

  Future<CartItem> addItem(CartItem item) async {
    final db = await instance.database;

    final id = await db.insert('cart_items', item.toMap());

    return item;
  }

  Future<List<CartItem>> getItems() async {
    final db = await instance.database;

    final maps = await db.query('cart_items');

    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<void> removeItem(int id) async {
    final db = await instance.database;

    await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalPrice() async {
    final db = await instance.database;

    final result = await db
        .rawQuery('SELECT SUM(price * quantity) as total FROM cart_items');
    //print(result);
    if (result == null) {
      print("null");
    }

    if (result.isNotEmpty) {
      //return result.first['total'] as double;
      if (result.first['total'] != null) {
        return result.first['total'] as double;
      } else {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  Future<void> clearTable() async {
    final db = await instance.database;
    await db.delete('cart_items');
  }

  Future<List<Map<String, dynamic>>> items() async {
    final db = await instance.database;
    return await db.query('cart_items');
  }

  Future<int> totalItems() async {
    final db = await instance.database;
    var result = await db.rawQuery("SELECT SUM(quantity) FROM cart_items");
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
