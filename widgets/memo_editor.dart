import 'package:flutter/material.dart';
import 'package:memo_app/controller/memo_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/providers/new_id_notifier.dart';
import 'package:memo_app/widgets/page_foundation.dart';

class MemoEditor extends ConsumerStatefulWidget {
  MemoEditor(
      {super.key, this.id, this.memo, required this.memoHandler, this.newId});

  final int? id;
  final String? memo;
  final MemoHandler memoHandler;
  dynamic newId;

  final double appBarHeight = AppBar().preferredSize.height;

  @override
  ConsumerState<MemoEditor> createState() {
    return _EditHandlingState();
  }
}

class _EditHandlingState extends ConsumerState<MemoEditor>
    with WidgetsBindingObserver {
  int? characterCounter;

  double bottomHeight = 0;

  @override
  void initState() {
    if (widget.id != null) {
      widget.memoHandler.memoController.text = widget.memo!;
    }
    characterCounter = widget.memoHandler.memoController.text.trim().length;

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final newValue =
        MediaQuery.of(Scaffold.of(context).context).viewInsets.bottom;
    print(newValue);
    if (newValue > 0) {
      setState(() {
        bottomHeight = newValue;
      });
    } else {
      setState(() {
        bottomHeight = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print('画面サイズ：${screenSize.width} x ${screenSize.height}');
    print(screenSize.height - widget.appBarHeight - bottomHeight - 135);
    print(widget.appBarHeight);
    print(bottomHeight);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('文字数：$characterCounter'),
          ]),
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: screenSize.width,
                maxWidth: screenSize.width,
                minHeight: 0,
                maxHeight: screenSize.height -
                    widget.appBarHeight -
                    bottomHeight -
                    135),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: TextField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: widget.memoHandler.memoController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(border: InputBorder.none),
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    characterCounter = value.trim().length;
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
