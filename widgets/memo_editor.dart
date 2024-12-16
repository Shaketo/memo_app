import 'package:flutter/material.dart';
import 'package:memo_app/controller/memo_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditHandling extends ConsumerStatefulWidget {
  const EditHandling({super.key, this.id, this.memo});

  final int? id;
  final String? memo;

  @override
  ConsumerState<EditHandling> createState() {
    return _EditHandlingState();
  }
}

class _EditHandlingState extends ConsumerState<EditHandling> {
  final memoHandler = MemoHandler();

  @override
  void initState() {
    if (widget.id != null) {
      memoHandler.memoController.text = widget.memo!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: memoHandler.memoController,
            keyboardType: TextInputType.text,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (widget.id != null) {
                    memoHandler.updateMemo(widget.id!);
                  } else {
                    memoHandler.saveMemo();
                  }
                },
                child: const Icon(Icons.save),
              ),
            ],
          )
        ],
      ),
    );
  }
}
