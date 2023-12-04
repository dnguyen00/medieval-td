import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:medieval_td/level_settings.dart';

import 'level.dart';

class MedievalTD extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => const Color(0xFF85C769);

  late final CameraComponent cam;
  final world = Level(
      levelName: "tutorial",
      levelSettings: LevelSettings(enemyHealth: 1, enemySpeed: 50));

  @override
  FutureOr<void> onLoad() async {
    await images.load("characters/warrior.png");
    await images.load("characters/torch.png");
    await images.load("Arrows_pack.png");

    camera = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    camera.viewfinder.anchor = Anchor.topLeft;

    addAll([camera, world]);
    return super.onLoad();
  }
}
