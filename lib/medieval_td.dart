import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:medieval_td/game_data.dart';
import 'package:medieval_td/level_settings.dart';

import 'level.dart';

class MedievalTD extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => const Color(0xFF85C769);

  int levelCode;
  MedievalTD({required this.levelCode});

  final List<Level> levels = [];
  late final CameraComponent cam;

  @override
  FutureOr<void> onLoad() async {
    await images.load("characters/warrior.png");
    await images.load("characters/torch.png");
    await images.load("Arrows_pack.png");

    levels.add(Level(
        levelName: "tutorial",
        levelSettings:
            LevelSettings(enemyHealth: 1, enemySpeed: 50, houseHealth: 1000)));

    levels.add(Level(
        levelName: "level1",
        levelSettings:
            LevelSettings(enemyHealth: 50, enemySpeed: 70, houseHealth: 50)));

    levels.add(Level(
        levelName: "level2",
        levelSettings:
            LevelSettings(enemyHealth: 50, enemySpeed: 100, houseHealth: 100)));

    levels.add(Level(
        levelName: "level3",
        levelSettings:
            LevelSettings(enemyHealth: 50, enemySpeed: 100, houseHealth: 100)));

    levels.add(Level(
        levelName: "level4",
        levelSettings: LevelSettings(
            enemyHealth: 300, enemySpeed: 300, houseHealth: 1000)));

    final world = levels[levelCode];
    GameData.houseHealth = levels[levelCode].levelSettings.houseHealth;

    camera = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    camera.viewfinder.anchor = Anchor.topLeft;

    addAll([camera, world]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (GameData.EnemyCount <= 0) {
      print("game over");
    }
    super.update(dt);
  }
}
