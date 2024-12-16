import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:memo_app/providers/memos_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/controller/memo_handler.dart';

class MemoHandler {
  final memoController = TextEditingController();

  late Database database;
  String _memo = '';

  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'memo_database.db');
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE memos(id INTEGER PRIMARY KEY AUTOINCREMENT, memo TEXT, date TEXT)",
        );
      },
      version: 1,
    );
  }

  void dispose() {
    memoController.dispose();
    // super.dispose();
  }

  Future<void> saveMemo() async {
    _memo = memoController.text;
    String date = DateTime.now().toString();

    database = await initializeDB();
    await database.insert('memos', {'memo': _memo, 'date': date});
  }

  Future<void> updateMemo(int id) async {
    _memo = memoController.text;
    String date = DateTime.now().toString();

    database = await initializeDB();
    await database.update(
      'memos',
      {'id': id, 'memo': _memo, 'date': date},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMemo(Database db, int id) async {
    await db.delete(
      'memos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
