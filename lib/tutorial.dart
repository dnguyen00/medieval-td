import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:medieval_td/medieval_td.dart';

class Tutorial extends Component
    with TapCallbacks, HasGameReference<MedievalTD> {
  @override
  Future<void> onLoad() async {
    addAll([
      TextComponent()
        ..text = "Do you want to do a tutorial?"
        ..textRenderer = TextPaint(style: const TextStyle(fontSize: 32)),
    ]);
  }
}
