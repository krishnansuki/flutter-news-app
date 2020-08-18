import 'package:flutter/material.dart';
import 'package:news_flutter/countries.dart';
import 'package:news_flutter/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        routes: {
          Countries.router: (context) => Countries(),
        });
  }
}
