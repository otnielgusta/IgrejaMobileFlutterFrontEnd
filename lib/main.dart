import 'package:flutter/material.dart';

import 'package:flutterigreja/pages/AdicionarEntradasPage/adicionar_entradas_page.dart';
import 'package:flutterigreja/pages/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(title: 'Igreja Cristã Libertadora'),
    );
  }
}
