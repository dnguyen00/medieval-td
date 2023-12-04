class GameData {
  static int money = 100;
  static int arrowDamage = 5;
  static int houseHealth = 5;
  static int EnemyCount = 1;
  static double playerSpeed = 100;
  static GameOverData data = GameOverData(score: 0, moneyGained: 0);
}

class GameOverData {
  int score = 0;
  int moneyGained = 0;

  GameOverData({required this.score, required this.moneyGained});
}
