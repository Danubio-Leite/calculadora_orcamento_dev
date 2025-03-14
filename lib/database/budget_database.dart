import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/budget.dart';

class BudgetDatabase {
  static final BudgetDatabase instance = BudgetDatabase._init();
  static Database? _database;

  BudgetDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('budgets.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE budgets (
        id $idType,
        nomeProjeto $textType,
        descricao $textType,
        precoHora $doubleType,
        baseHoras $doubleType,
        numTelas $intType,
        usaBaas $intType,
        temLogin $intType
      )
    ''');
  }

  Future<int> insertBudget(Budget budget) async {
    final db = await instance.database;
    return await db.insert('budgets', budget.toMap());
  }

  Future<List<Budget>> getBudgets() async {
    final db = await instance.database;
    final result = await db.query('budgets');
    return result.map((map) => Budget.fromMap(map)).toList();
  }

  Future<int> deleteBudget(int id) async {
    final db = await instance.database;
    return await db.delete('budgets', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
