import 'package:flutter/material.dart';
import 'package:memo_app/controller/memo_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/providers/new_id_notifier.dart';

class MemoEditor extends ConsumerStatefulWidget {
  MemoEditor(
      {super.key, this.id, this.memo, required this.memoHandler, this.newId});

  final int? id;
  final String? memo;
  final MemoHandler memoHandler;
  dynamic newId;

  @override
  ConsumerState<MemoEditor> createState() {
    return _EditHandlingState();
  }
}

class _EditHandlingState extends ConsumerState<MemoEditor> {
  int? characterCounter;

  @override
  void initState() {
    if (widget.id != null) {
      widget.memoHandler.memoController.text = widget.memo!;
    }
    characterCounter = widget.memoHandler.memoController.text.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('文字数：$characterCounter'),
          ]),
          SingleChildScrollView(
            child: Expanded(
              child: TextField(
                controller: widget.memoHandler.memoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(border: InputBorder.none),
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    characterCounter = value.length;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
