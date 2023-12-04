import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:medieval_td/collisions.dart';
import 'package:medieval_td/enemy.dart';
import 'package:medieval_td/level_settings.dart';
import 'package:medieval_td/player.dart';

class Level extends World {
  String levelName;
  LevelSettings levelSettings;
  Level({required this.levelName, required this.levelSettings});

  late TiledComponent level;
  List<Collisions> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));

    add(level);

    late Player player;
    late Collisions house;
    List<Enemy> enemies = [];

    for (final spawn in level.tileMap.getLayer<ObjectGroup>("Spawn")!.objects) {
      switch (spawn.class_) {
        case "Player":
          player = Player(
              character: "characters/warrior.png",
              animationIndex: [0, 6, 1, 6, 2, 6],
              position: Vector2(spawn.x, spawn.y));
          add(player);
          break;
        case "Enemy":
          Enemy enemy = Enemy(
              character: "characters/torch.png",
              animationIndex: [0, 6, 1, 6, 2, 6],
              position: Vector2(spawn.x, spawn.y));
          enemy.speed = levelSettings.enemySpeed;
          enemies.add(enemy);
          add(enemy);
          break;
        default:
      }
    }

    for (final collision
        in level.tileMap.getLayer<ObjectGroup>("Collisions")!.objects) {
      switch (collision.class_) {
        case "House":
          final block = Collisions(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height));
          collisionBlocks.add(block);
          house = block;
          add(block);
          break;
        default:
          final block = Collisions(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height));
          collisionBlocks.add(block);
          add(block);
      }
    }

    player.collisionBlocks = collisionBlocks;

    return super.onLoad();
  }
}
