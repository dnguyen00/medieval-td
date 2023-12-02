import 'package:flame/components.dart';

class Collisions extends PositionComponent {
  Collisions({position, size}) : super(position: position, size: size) {
    debugMode = true;
  }
}
