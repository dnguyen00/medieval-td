import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:medieval_td/collisions.dart';
import 'package:medieval_td/custom_hitbox.dart';
import 'package:medieval_td/medieval_td.dart';

enum PlayerState { idle, walk, attack }

enum PlayerDirection {
  left,
  right,
  up,
  down,
  topright,
  topleft,
  downright,
  downleft,
  none
}

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
      : super(position: position) {
    debugMode = true;
  }

  PlayerDirection playerDirection = PlayerDirection.none;
  double speed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;
  List<Collisions> collisionBlocks = [];
  CustomHitbox hitbox =
      CustomHitbox(offsetX: 14, offsetY: 4, width: 40, height: 50);

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    _checkCollisions();
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
    add(RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height)));
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
      case PlayerDirection.topleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy -= speed;
        break;
      case PlayerDirection.topright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy -= speed;
        break;
      case PlayerDirection.downleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy += speed;
        break;
      case PlayerDirection.downright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy += speed;
        break;
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        break;
      case PlayerDirection.up:
        dy -= speed;
        break;
      case PlayerDirection.down:
        dy += speed;
        break;
      case PlayerDirection.none:
        break;
      default:
    }

    velocity = Vector2(dx, dy);
    position += velocity * dt;
  }

  void _checkCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        if (velocity.x > 0) {
          velocity.x = 0;
          position.x = block.x - width;
        }

        if (velocity.x < 0) {
          velocity.x = 0;
          position.x = block.x + block.width + width;
        }

        if (velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - width;
        }

        if (velocity.y < 0) {
          velocity.y = 0;
          position.y = block.y + block.height;
        }
      }
    }
  }
}
