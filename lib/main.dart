import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:medieval_td/main_menu.dart';
import 'package:medieval_td/medieval_td.dart';
import 'package:medieval_td/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(MyApp());
}
