import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'tutorial.dart';

class MedievalTD extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF85C769);

  late final CameraComponent cam;
  final world = Tutorial();

  @override
  FutureOr<void> onLoad() {
    camera = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);

    camera.viewfinder.anchor = Anchor.topLeft;

    addAll([camera, world]);
    return super.onLoad();
  }
}
