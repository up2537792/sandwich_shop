import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sandwich_shop/models/order.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// Get database instance, initialize if needed
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'sandwich_shop.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  /// Create database tables
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        items TEXT NOT NULL,
        totalPrice REAL NOT NULL,
        notes TEXT NOT NULL
      )
    ''');
  }

  /// Insert a new order
  Future<int> insertOrder(Order order) async {
    final db = await database;
    return await db.insert(
      'orders',
      order.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all orders
  Future<List<Order>> getAllOrders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Order.fromJson(maps[i]));
  }

  /// Get single order by id
  Future<Order?> getOrderById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('orders', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Order.fromJson(maps.first);
  }

  /// Delete order by id
  Future<int> deleteOrder(int id) async {
    final db = await database;
    return await db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }

  /// Delete all orders
  Future<int> deleteAllOrders() async {
    final db = await database;
    return await db.delete('orders');
  }

  /// Get order count
  Future<int> getOrderCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM orders');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
