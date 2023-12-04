import 'dart:io';

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    bool isMuted =
                        false; //not set because there is no music added yet
                    double volume = 0.5;

                    return AlertDialog(
                      title: Text('Music Settings'),
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Volume'),
                              Slider(
                                value: volume,
                                onChanged: (double value) {
                                  // Handle volume change

                                  volume = value;
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Mute'),
                              Switch(
                                value: isMuted,
                                onChanged: (bool value) {
                                  // Handle mute change if mute it toggled to on
                                  isMuted = value;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Music'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // show a confirmation dialog on quitting
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Quit Game'),
                      content: Text('Are you sure you want to quit?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            //FOR TESTING , exit(0) is just to close the app but in build we'll use system navigator.
                            exit(0);
                            // Perform quit action, e.g., exit the app
                            //Navigator.pop(context);
                            //SystemNavigator.pop();
                          },
                          child: Text('Quit'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Quit'),
            ),
          ],
        ),
      ),
    );
  }
}
