import 'package:flutter/material.dart';
import 'package:memo_app/widgets/memo_editor.dart';
import 'package:memo_app/screens/top_page.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key, this.id, this.memo});

  final int? id;
  final String? memo;

  void _pressBackButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const TopPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => _pressBackButton(context), // 戻る前に勝手にメモの編集内容をセーブする
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('編集画面'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            EditHandling(id: id, memo: memo),
          ],
        ),
      ),
    );
  }
}
