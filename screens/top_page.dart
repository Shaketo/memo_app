import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/screens/edit_page.dart';
import 'package:memo_app/widgets/memo_list.dart';
import 'package:memo_app/widgets/page_foundation.dart';

import 'dart:async';
import 'package:memo_app/providers/memos_notifier.dart';
import 'package:memo_app/controller/memo_handler.dart';

class TopPage extends StatelessWidget {
  TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFoundation(
      appBarTitle: appBarTitle,
      appBarIcon: appBarIcon,
      appBarIconFunction: () {},
      bottomBarChild: const BottomBarChild(),
      bodyChild: child,
    );
  }

  final String appBarTitle = 'メモアプリ';
  final Icon appBarIcon = const Icon(Icons.menu);
  final MainAxisAlignment bottomBarAlignment = MainAxisAlignment.end;

  final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: const MemoList(),
          ),
        ),
      ]);
}

class BottomBarChild extends ConsumerStatefulWidget {
  const BottomBarChild({super.key});

  @override
  ConsumerState<BottomBarChild> createState() => _BottomBarChildState();
}

class _BottomBarChildState extends ConsumerState<BottomBarChild> {
  MemoHandler memoHandler = MemoHandler();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            _pressAddButton(context);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _pressAddButton(BuildContext context) async {
    bool editPagepopped = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditPage();
        },
      ),
    );
    if (editPagepopped == true) {
      openLoadDB();
    }
  }

  Future<void> openLoadDB() async {
    memoHandler.database = await memoHandler.initializeDB();
    ref.read(memoDataProvider.notifier).loadMemos(db: memoHandler.database);
  }
}
