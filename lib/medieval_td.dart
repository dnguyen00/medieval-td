import 'package:flame/game.dart';

import 'tutorial.dart';

class MedievalTD extends FlameGame {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    add(router = RouterComponent(initialRoute: 'tutorial', routes: {
      'tutorial': Route(Tutorial.new),
    }));
  }
}
