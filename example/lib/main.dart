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

  @override
  void initState() {
    super.initState();
  }

  Future<void> insert() async {
    try {
      await _flutterContentProviderPlugin.insert(key: 'sharedData', value: "shared data between apps");
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
        body: Center(
          child: TextButton(
            onPressed: insert,
            child: const Text("insert"),
          ),
        ),
      ),
    );
  }
}
