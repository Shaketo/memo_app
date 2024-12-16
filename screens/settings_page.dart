import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  final bool _darkMode = false; // ダークモードの初期値

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Text('ダークモード ON'),
                SwitchListTile(
                    value: _darkMode,
                    onChanged: (value) {}) // ここにon/offを切り替える関数を入れる
              ],
            ),
          ],
        ),
      ),
    );
  }
}
