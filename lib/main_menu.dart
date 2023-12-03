import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medieval_td/levelSelect.dart';
import 'package:medieval_td/shop.dart';
import 'package:medieval_td/settings.dart';
//combine my_app.dart with this


class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopScreen()),
                );
              },
              child: const Text('Shop'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the settings screen, created new dart file for settings :)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}




