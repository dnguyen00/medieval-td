import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:medieval_td/player.dart';

class Level extends World {
  String levelName;
  Level({required this.levelName});

  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));

    add(level);

    for (final spawn in level.tileMap.getLayer<ObjectGroup>("Spawn")!.objects) {
      switch (spawn.class_) {
        case "Player":
          add(Player(
              character: "characters/warrior.png",
              animationIndex: [0, 6, 1, 6, 2, 6],
              position: Vector2(spawn.x, spawn.y)));
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
