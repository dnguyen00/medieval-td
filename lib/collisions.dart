import 'package:flame/components.dart';

class Collisions extends PositionComponent {
  String name;
  Collisions({position, size, required this.name})
      : super(position: position, size: size) {
    debugMode = true;
  }
}

bool checkCollision(entity, block) {
  final hitbox = entity.hitbox;
  final eX = entity.position.x + hitbox.offsetX;
  final eY = entity.position.y + hitbox.offsetY;
  final eWidth = hitbox.width;
  final eHeight = hitbox.height;

  final bX = block.x;
  final bY = block.y;
  final bWidth = block.width;
  final bHeight = block.height;

  final fixedX = entity.scale.x < 0 ? eX - (hitbox.offsetX * 2) - eWidth : eX;
  final fixedY = entity.scale.y < 0 ? eY + eHeight : eY;

  return (fixedY < bY + bHeight &&
      fixedY + eHeight > bY &&
      fixedX < bX + bWidth &&
      fixedX + eWidth > bX);
}
