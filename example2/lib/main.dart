import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_content_provider/flutter_content_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterContentProviderPlugin = FlutterContentProvider();

  String _sharedData = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> insert() async {
    String? sharedData;

    try {
      sharedData = await _flutterContentProviderPlugin.query('sharedData');

      setState(() {
        _sharedData = sharedData.toString();
      });
    } on PlatformException {
      // ignore: avoid_print
      print("Oops");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: insert,
                child: const Text("query"),
              ),
            ),
            Center(
              child: Text(_sharedData),
            )
          ],
        ),
      ),
    );
  }
}
