import 'package:flutter/material.dart';
import 'package:memo_app/providers/memos_notifier.dart';
import 'package:memo_app/screens/top_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 75, 43, 255),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _EagerInitialization(
        child: MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
      ),
      home: const TopPage(),
    ));
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
