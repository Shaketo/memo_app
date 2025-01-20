import 'package:flutter/material.dart';

class PageFoundation extends StatelessWidget {
  const PageFoundation(
      {super.key,
      required this.appBarTitle,
      required this.appBarIcon,
      required this.appBarIconFunction,
      this.bottomBarChild,
      required this.bodyChild,
      this.leading,
      this.floatingActionButton});

  final String appBarTitle;
  final Icon appBarIcon;
  final Function appBarIconFunction;
  final Widget? leading;

  final Widget? bottomBarChild;

  final Widget bodyChild;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: leading,
        title: Text(appBarTitle),
        actions: [
          IconButton(
            onPressed: () => appBarIconFunction(),
            icon: appBarIcon,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(child: bottomBarChild),
      body: Center(child: bodyChild),
      floatingActionButton: floatingActionButton,
    );
  }
}
