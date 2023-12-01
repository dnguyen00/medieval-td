import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medieval_td/levelSelect.dart';

//combine my_app.dart with this
class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Medieval TD',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the level selection screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelSelectionScreen()),
                );
              },
              child: const Text('Select Level'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the settings screen
                log('Go to settings');
              },
              child: const Text('Settings'),
            )
          ],
        ),
      ),
    );
  }
}
