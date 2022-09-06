import 'package:flutter/material.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({Key? key}) : super(key: key);

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
              "This page can have lot of extent content, and user might be reading this without performing any user activity. So you might want to disable sesison timeout listeners only for this page"),
        ),
      ),
    );
  }
}
