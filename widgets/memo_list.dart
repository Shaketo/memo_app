import 'package:flutter/material.dart';
import 'package:memo_app/widgets/memo_card.dart';

import 'dart:async';
import 'package:memo_app/providers/memos_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/controller/memo_handler.dart';

class MemoList extends ConsumerStatefulWidget {
  const MemoList({super.key});

  @override
  ConsumerState<MemoList> createState() => MemoListState();
}

class MemoListState extends ConsumerState<MemoList> {
  @override
  void initState() {
    super.initState();
    openLoadDB();
  }

  MemoHandler memoHandler = MemoHandler();

  Future<void> openLoadDB() async {
    memoHandler.database = await memoHandler.initializeDB();
    ref.read(memoDataProvider.notifier).loadMemos(db: memoHandler.database);
  }

  @override
  Widget build(BuildContext context) {
    final memoState = ref.watch(memoDataProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        var memo = memoState[index];

        return MemoCard(
          memo: memo['memo'],
          date: memo['date'],
          id: memo['id'],
        );
      },
      itemCount: memoState.length,
    );
  }
}
