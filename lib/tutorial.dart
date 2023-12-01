import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Tutorial extends World {
  late TiledComponent background;

  @override
  FutureOr<void> onLoad() async {
    background =
        await TiledComponent.load("tutorial_background.tmx", Vector2.all(16));

    add(background);
    return super.onLoad();
  }
}
