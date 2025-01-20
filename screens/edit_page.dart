import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/widgets/memo_editor.dart';
import 'package:memo_app/widgets/memo_list.dart';

import 'package:memo_app/controller/memo_handler.dart';
import 'package:memo_app/widgets/page_foundation.dart';
import 'package:memo_app/providers/new_id_notifier.dart';

class EditPage extends ConsumerStatefulWidget {
  EditPage({super.key, this.id, this.memo});

  final int? id;
  final String? memo;

  @override
  ConsumerState<EditPage> createState() {
    return _EditPage();
  }
}

class _EditPage extends ConsumerState<EditPage> {
  MemoHandler memoHandler = MemoHandler();
  dynamic newId;

  @override
  Widget build(BuildContext context) {
    final newIdState = ref.watch(newIdProvider);

    return PageFoundation(
      appBarTitle: appBarTitle,
      appBarIcon: appBarIcon,
      appBarIconFunction: () {},
      leading: Leading(memoHandler: memoHandler, id: widget.id, newId: newId),
      bottomBarChild: null,
      bodyChild: BodyChild(
        id: widget.id,
        memo: widget.memo,
        memoHandler: memoHandler,
        newId: newId,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (widget.id != null) {
            memoHandler.updateMemo(widget.id!);
          } else if (newIdState != null) {
            memoHandler.updateMemo(newIdState);
          } else {
            ref.read(newIdProvider.notifier).saveGetId();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  final String appBarTitle = '編集画面';
  final Icon appBarIcon = const Icon(Icons.settings);

  final MainAxisAlignment bottomBarAlignment = MainAxisAlignment.end;
}

class BodyChild extends StatelessWidget {
  BodyChild(
      {super.key, this.id, this.memo, required this.memoHandler, this.newId});
  final int? id;
  final String? memo;
  MemoHandler memoHandler;
  dynamic newId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MemoEditor(
        id: id,
        memo: memo,
        memoHandler: memoHandler,
        newId: newId,
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       automaticallyImplyLeading: false,
//       leading: IconButton(
//         onPressed: () {
//           print('memoの中身${editHandler.memoHandler.memoController.text}');
//           _pressBackButton(context);
//         },
//         icon: const Icon(Icons.arrow_back),
//       ),
//       title: const Text('編集画面'),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.settings),
//         ),
//       ],
//     ),
//     body: Center(
//       child: Column(
//         children: [
//           EditHandling(id: id, memo: memo),
//         ],
//       ),
//     ),
//   );
// }

class Leading extends ConsumerStatefulWidget {
  Leading({super.key, required this.memoHandler, this.id, this.newId});
  MemoHandler memoHandler;
  int? id;
  dynamic newId;

  @override
  ConsumerState<Leading> createState() => _Leading();
}

class _Leading extends ConsumerState<Leading> {
  @override
  Widget build(BuildContext context) {
    final newIdState = ref.watch(newIdProvider);

    return IconButton(
      onPressed: () {
        print('戻るボタン押下時のmemoの中身：${widget.memoHandler.memoController.text}');
        _pressBackButton(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // Future<void> openLoadDB() async {
  //   memoHandler.database = await memoHandler.initializeDB();
  //   ref.read(memoDataProvider.notifier).loadMemos(db: memoHandler.database);
  // }

  void _pressBackButton(BuildContext context) {
    final newIdState = ref.watch(newIdProvider);

    if (widget.id != null) {
      print('戻るボタン・idがnullでないルート');
      widget.memoHandler.updateMemo(widget.id!);
    } else if (newIdState != null) {
      print('戻るボタン・newIdがnullでないルート');
      widget.memoHandler.updateMemo(newIdState);
    } else if (widget.memoHandler.memoController.text != "") {
      widget.memoHandler.saveMemo();

      print('新規だけど何かしら書いてあるルート');
    } else {
      ref.read(newIdProvider.notifier).forgetId();
      print('新規かつ何も記入していないルート');
    }

    Navigator.pop(context, true
        // MaterialPageRoute(
        //   builder: (context) {
        //     return const TopPage();
        //   },
        // ),
        );
  }
}
