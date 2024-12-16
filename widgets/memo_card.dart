import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memo_app/controller/memo_handler.dart';
import 'package:memo_app/providers/memos_notifier.dart';
import 'package:memo_app/widgets/memo_list.dart';
import 'package:memo_app/screens/edit_page.dart';

class MemoCard extends ConsumerWidget {
  MemoCard({
    super.key,
    required this.memo,
    required this.date,
    required this.id,
  });

  final String memo;
  final String date;
  final int id;

  MemoHandler memoHandler = MemoHandler();
  MemoList memoList = const MemoList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EditPage(id: id, memo: memo);
            },
          ),
        );
      },
      onLongPress: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('メモを削除します'),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
                label: '削除する',
                onPressed: () async {
                  memoHandler.database = await memoHandler.initializeDB();
                  memoHandler.deleteMemo(memoHandler.database, id);
                  ref
                      .read(memoDataProvider.notifier)
                      .loadMemos(db: memoHandler.database);
                }),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 207, 227, 236),
        margin: const EdgeInsets.all(5),
        elevation: 10,
        shadowColor: const Color.fromARGB(255, 79, 96, 252),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(memo),
              Text(date),
            ],
          ),
        ),
      ),
    );
  }
}
