import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memo_app/controller/memo_handler.dart';

class NewIdNotifier extends StateNotifier<int?> {
  NewIdNotifier() : super(null);

  MemoHandler memoHandler = MemoHandler();

  void saveGetId() async {
    await memoHandler.saveMemo();
    memoHandler.database = await memoHandler.initializeDB();
    List<Map<String, dynamic>> dbId = await memoHandler.database.query(
      'memos',
      columns: ['id'],
      // where: '"id" = ?',
      // whereArgs: ['SELECT max("id") FROM memos']
    );
    print('DBから取得したIDのリスト：$dbId');
    print('対象のメモのID：${dbId.last['id']}');
    state = dbId.last['id'];
  }

  void forgetId() {
    state = null;
  }
}

final newIdProvider = StateNotifierProvider<NewIdNotifier, int?>((ref) {
  return NewIdNotifier();
});
