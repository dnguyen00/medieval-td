import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:medieval_td/medieval_td.dart';

enum PlayerState { idle, walk, attack }

enum PlayerDirection { left, right, up, down, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MedievalTD>, KeyboardHandler {
  late final SpriteAnimation idleAnimation, walkAnimation, attackAnimation;
  String character;
  List<int> animationIndex;
  bool reversed;
  Player(
      {position,
      required this.character,
      required this.animationIndex,
      this.reversed = false})
      : super(position: position);

  PlayerDirection playerDirection = PlayerDirection.none;
  double speed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKey = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKey = keysPressed.contains(LogicalKeyboardKey.keyD);
    final isUpKey = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isDownKey = keysPressed.contains(LogicalKeyboardKey.keyS);

    if (isLeftKey) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKey) {
      playerDirection = PlayerDirection.right;
    } else if (isUpKey) {
      playerDirection = PlayerDirection.up;
    } else if (isDownKey) {
      playerDirection = PlayerDirection.down;
    } else if (isUpKey && isDownKey) {
      playerDirection = PlayerDirection.none;
    } else if (isRightKey && isLeftKey) {
      playerDirection = PlayerDirection.none;
    } else {
      playerDirection = PlayerDirection.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    final entityImage = game.images.fromCache(character);
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

    animations = {PlayerState.idle: idleAnimation};

    current = PlayerState.idle;
  }

  List<SpriteAnimationFrameData> createAnimationFrames(
      SpriteSheet spriteSheet, int row, int columns, double stepTime) {
    List<SpriteAnimationFrameData> frames = [];
    for (int i = 0; i < columns; i++) {
      frames.add(spriteSheet.createFrameData(row, i, stepTime: stepTime));
    }

    return frames;
  }

  void _updatePlayerMovement(double dt) {
    double dx = 0;
    double dy = 0;

    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        //current = PlayerState.walk;
        dx -= speed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        //current = PlayerState.walk;
        dx += speed;
        break;
      case PlayerDirection.up:
        //current = PlayerState.walk;
        dy -= speed;
        break;
      case PlayerDirection.down:
        //current = PlayerState.walk;
        dy += speed;
        break;
      case PlayerDirection.none:
        //current = PlayerState.idle;
        break;
      default:
    }

    velocity = Vector2(dx, dy);
    position += velocity * dt;
  }
}

// 16 margin
// 32 spacing
// 64x64