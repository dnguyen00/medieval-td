import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:medieval_td/medieval_td.dart';

enum EntityState { idle, walk, attack }

class Entity extends SpriteAnimationGroupComponent with HasGameRef<MedievalTD> {
  late final SpriteAnimation idleAnimation, walkAnimation, attackAnimation;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    final entityImage = game.images.fromCache("characters/warrior.png");

    final spriteSheet =
        SpriteSheet(image: entityImage, srcSize: Vector2.all(64));

    idleAnimation = SpriteAnimation.fromFrameData(entityImage,
        SpriteAnimationData([spriteSheet.createFrameData(0, 2, stepTime: .5)]));

    animations = {EntityState.idle: idleAnimation};

    current = EntityState.idle;
  }
}
