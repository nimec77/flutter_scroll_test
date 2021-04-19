import 'package:flutter/material.dart';
import 'package:flutter_scroll_test/stock_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) {
          return StocksPage(size: MediaQuery.of(context).size);
        },
      ),
    );
  }
}

