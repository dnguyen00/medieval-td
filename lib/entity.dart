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

    const idleRow = 0;
    const walkRow = 1;
    const attackRow = 2;

    idleAnimation = SpriteAnimation.fromFrameData(
        entityImage,
        SpriteAnimationData(
            createAnimationFrames(spriteSheet, idleRow, 6, .1)));

    walkAnimation = SpriteAnimation.fromFrameData(
        entityImage,
        SpriteAnimationData(
            createAnimationFrames(spriteSheet, walkRow, 6, .1)));

    attackAnimation = SpriteAnimation.fromFrameData(
        entityImage,
        SpriteAnimationData(
            createAnimationFrames(spriteSheet, attackRow, 6, .1)));

    animations = {EntityState.idle: idleAnimation};

    current = EntityState.idle;
  }

  List<SpriteAnimationFrameData> createAnimationFrames(
      SpriteSheet spriteSheet, int row, int columns, double stepTime) {
    List<SpriteAnimationFrameData> frames = [];
    for (int i = 0; i < columns; i++) {
      frames.add(spriteSheet.createFrameData(row, i, stepTime: stepTime));
    }

    return frames;
  }
}
