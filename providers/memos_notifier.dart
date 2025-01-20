import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class MemosNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  MemosNotifier() : super([]);

  Future<void> loadMemos({db}) async {
    state = await getMemos(db);
    state = state.reversed.toList();

    print('loadMemoの中：');

    print(state);
  }

  Future<List<Map<String, dynamic>>> getMemos(Database db) async {
    return await db.query('memos');
  }
}

final memoDataProvider =
    StateNotifierProvider<MemosNotifier, List<Map<String, dynamic>>>((ref) {
  return MemosNotifier();
});
