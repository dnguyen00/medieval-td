import 'dart:developer';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:medieval_td/game_data.dart';
import 'package:medieval_td/medieval_td.dart';

class LevelSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LevelSelectionScreen(),
    );
  }
}

class LevelSelectionScreen extends StatelessWidget {
  final List<int> levels = List.generate(4, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a Level',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Level ${levels[index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Handle level selection, e.g., navigate to the selected level
                      runApp(GameWidget(
                          game: MedievalTD(levelCode: levels[index])));
                      GameData.data.moneyGained = 0;
                      GameData.data.score = 0;
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the tutorial screen
                runApp(GameWidget(game: MedievalTD(levelCode: 0)));
                GameData.data.moneyGained = 0;
                GameData.data.score = 0;
              },
              child: const Text('Tutorial'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
