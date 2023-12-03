import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:medieval_td/collisions.dart';
import 'package:medieval_td/medieval_td.dart';

enum EnemyState { idle, walk, attack }

enum EnemyDirection {
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

class Enemy extends SpriteAnimationGroupComponent
    with HasGameRef<MedievalTD>, KeyboardHandler {
  late final SpriteAnimation idleAnimation, walkAnimation, attackAnimation;
  String character;
  List<int> animationIndex;
  bool reversed;
  Enemy(
      {position,
      required this.character,
      required this.animationIndex,
      this.reversed = false})
      : super(position: position) {
    debugMode = true;
  }

  EnemyDirection playerDirection = EnemyDirection.none;
  double speed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;
  List<Collisions> collisionBlocks = [];
  EnemyHitbox hitbox =
      EnemyHitbox(offsetX: 14, offsetY: 4, width: 40, height: 50);

  @override
  void update(double dt) {
    _updateEnemyMovement(dt);
    _checkCollisions();
    super.update(dt);
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

    animations = {EnemyState.idle: idleAnimation};

    current = EnemyState.idle;
  }

  List<SpriteAnimationFrameData> createAnimationFrames(
      SpriteSheet spriteSheet, int row, int columns, double stepTime) {
    List<SpriteAnimationFrameData> frames = [];
    for (int i = 0; i < columns; i++) {
      frames.add(spriteSheet.createFrameData(row, i, stepTime: stepTime));
    }

    return frames;
  }

  void _updateEnemyMovement(double dt) {
    double dx = 0;
    double dy = 0;

    switch (playerDirection) {
      case EnemyDirection.topleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy -= speed;
        break;
      case EnemyDirection.topright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy -= speed;
        break;
      case EnemyDirection.downleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy += speed;
        break;
      case EnemyDirection.downright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy += speed;
        break;
      case EnemyDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        break;
      case EnemyDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        break;
      case EnemyDirection.up:
        dy -= speed;
        break;
      case EnemyDirection.down:
        dy += speed;
        break;
      case EnemyDirection.none:
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

class EnemyHitbox {
  final double offsetX;
  final double offsetY;
  final double width;
  final double height;

  EnemyHitbox(
      {required this.offsetX,
      required this.offsetY,
      required this.width,
      required this.height});
}

// 16 margin
// 32 spacing
// 64x64