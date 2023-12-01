import 'package:flutter/material.dart';
import 'package:medieval_td/main_menu.dart';

//this needs to be combined with main_menu
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
    );
  }
}
