import 'package:flutter/material.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final String title;
  final FloatingActionButton? floatingActionButton;

  const MyScaffold(
      {super.key,
      required this.body,
      required this.title,
      this.floatingActionButton});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.body,
        ),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}