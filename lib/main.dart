import 'package:appwithapi/Screen/productGridViewScreen.dart';
import 'package:flutter/material.dart';
import 'Screen/productCreateScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Crud App',
      home: ProductGridViewScreen(),
    );
  }
}
