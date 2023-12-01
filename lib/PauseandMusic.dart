import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PausedScreen()),
                  );
                },
                child: Icon(Icons.pause),
              ),
              SizedBox(height: 16), // Adding some space between the buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MusicScreen()),
                  );
                },
                child: Icon(Icons.music_note),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PausedScreen extends StatelessWidget {
  @override
  //the actual pause screen, very basic
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paused Game'),
      ),
      body: Center(
        child: Text('Game Paused, Press Back Arrow to Resume'),
      ),
    );
  }
}

class MusicScreen extends StatelessWidget {
  @override
  //the actual music settings screen, very basic
  Widget build(BuildContext context) {
    double volumeValue =
        0.7; // Initial volume value, you can set it to your desired default

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Adjust volume:'),
            SizedBox(height: 16),
            Slider(
              value: volumeValue,
              onChanged: (value) {
                // Handle volume changes here
              },
            ),
            SizedBox(height: 16),
            Text(
                'Current Volume: ${volumeValue.toStringAsFixed(2)}'), // Display the current volume value
          ],
        ),
      ),
    );
  }
}
