import 'package:flutter/material.dart';
import 'package:medieval_td/game_data.dart';
import 'package:medieval_td/levelSelect.dart';
import 'package:medieval_td/main_menu.dart';
import 'package:medieval_td/medieval_td.dart';

class Gameover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameOverPage(),
    );
  }
}

class GameOverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int score = GameData.data.score;
    int moneyGained = GameData.data.moneyGained;
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Score: $score", // Replace with the actual score value
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Money Gained: $moneyGained", // Replace with the actual money gained value
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main menu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60),
              ),
              child: Text('Return to Main Menu'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the game screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelSelectionScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60),
              ),
              child: Text('Replay Game'),
            ),
          ],
        ),
      ),
    );
  }
}
