import 'package:flutter/material.dart';
import 'package:memo_app/screens/edit_page.dart';
import 'package:memo_app/widgets/memo_list.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモアプリ'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => _pressAddButton(context),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: const MemoList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pressAddButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditPage();
        },
      ),
    );
  }
}
