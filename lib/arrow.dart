import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:medieval_td/collisions.dart';
import 'package:medieval_td/custom_hitbox.dart';
import 'package:medieval_td/medieval_td.dart';

enum ArrowState { idle, walk, attack }

enum ArrowDirection {
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

class Arrow extends SpriteAnimationGroupComponent with HasGameRef<MedievalTD> {
  late final SpriteAnimation idleAnimation, walkAnimation, attackAnimation;
  String character;
  List<int> animationIndex;
  bool reversed;
  Arrow(
      {position,
      required this.character,
      required this.animationIndex,
      this.reversed = false})
      : super(position: position) {
    debugMode = true;
  }

  ArrowDirection arrowDirection = ArrowDirection.none;
  double speed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;
  List<Collisions> collisionBlocks = [];
  CustomHitbox hitbox =
      CustomHitbox(offsetX: 14, offsetY: 4, width: 40, height: 50);

  @override
  void update(double dt) {
    _updateArrowMovement(dt);
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
        SpriteSheet(image: entityImage, srcSize: Vector2.all(32));

    const idleRow = 0;

    idleAnimation = SpriteAnimation.fromFrameData(
        entityImage,
        SpriteAnimationData(
            createAnimationFrames(spriteSheet, idleRow, 3, .1)));

    animations = {ArrowState.idle: idleAnimation};

    current = ArrowState.idle;
  }

  List<SpriteAnimationFrameData> createAnimationFrames(
      SpriteSheet spriteSheet, int row, int columns, double stepTime) {
    List<SpriteAnimationFrameData> frames = [];
    for (int i = 0; i < columns; i++) {
      frames.add(spriteSheet.createFrameData(row, i, stepTime: stepTime));
    }

    return frames;
  }

  void _updateArrowMovement(double dt) {
    double dx = 0;
    double dy = 0;

    switch (arrowDirection) {
      case ArrowDirection.topleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy -= speed;
        break;
      case ArrowDirection.topright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy -= speed;
        break;
      case ArrowDirection.downleft:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        dy += speed;
        break;
      case ArrowDirection.downright:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        dy += speed;
        break;
      case ArrowDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        break;
      case ArrowDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        break;
      case ArrowDirection.up:
        dy -= speed;
        break;
      case ArrowDirection.down:
        dy += speed;
        break;
      case ArrowDirection.none:
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
// 16 margin
// 32 spacing
// 64x64