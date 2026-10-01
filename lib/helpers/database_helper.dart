import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Danh sách dữ liệu tạm dành riêng cho nền tảng Web
  final List<TransactionModel> _webTransactions = [
    TransactionModel(
      id: 1,
      title: 'Ăn trưa',
      amount: 50000,
      category: 'Ăn uống',
      date: '03/09/2024',
      type: 'expense',
      note: 'Ăn cơm tấm',
    ),
    TransactionModel(
      id: 2,
      title: 'Lương tháng 9',
      amount: 8000000,
      category: 'Thu nhập',
      date: '01/09/2024',
      type: 'income',
      note: 'Nhận lương',
    ),
  ];

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (kIsWeb) return null; // Trên Web không dùng SQLite native
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL,
        type TEXT NOT NULL,
        note TEXT
      )
    ''');
  }

  // LẤY TẤT CẢ GIAO DỊCH
  Future<List<TransactionModel>> getAllTransactions() async {
    if (kIsWeb) {
      return List.from(_webTransactions);
    }
    final db = await instance.database;
    final result = await db!.query('transactions', orderBy: 'id DESC');
    return result.map((json) => TransactionModel.fromMap(json)).toList();
  }

  // THÊM GIAO DỊCH
  Future<int> insertTransaction(TransactionModel transaction) async {
    if (kIsWeb) {
      final newId = _webTransactions.isEmpty ? 1 : (_webTransactions.last.id ?? 0) + 1;
      final newItem = TransactionModel(
        id: newId,
        title: transaction.title,
        amount: transaction.amount,
        category: transaction.category,
        date: transaction.date,
        type: transaction.type,
        note: transaction.note,
      );
      _webTransactions.add(newItem);
      return newId;
    }
    final db = await instance.database;
    return await db!.insert('transactions', transaction.toMap());
  }

  // CẬP NHẬT GIAO DỊCH
  Future<int> updateTransaction(TransactionModel transaction) async {
    if (kIsWeb) {
      final index = _webTransactions.indexWhere((element) => element.id == transaction.id);
      if (index != -1) {
        _webTransactions[index] = transaction;
      }
      return 1;
    }
    final db = await instance.database;
    return await db!.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  // XÓA GIAO DỊCH
  Future<int> deleteTransaction(int id) async {
    if (kIsWeb) {
      _webTransactions.removeWhere((element) => element.id == id);
      return 1;
    }
    final db = await instance.database;
    return await db!.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}