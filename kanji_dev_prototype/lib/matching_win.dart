import 'package:flutter/material.dart';
import 'package:kanji_prototype/arcade.dart';

class MatchingWin extends StatelessWidget {
  const MatchingWin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Win!'),
        automaticallyImplyLeading: false, // This will hide the back button
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Arcade()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: 
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Arcade()),
              );
            },
            child: const Text('Back to Arcade', style: TextStyle(fontSize: 28),),
          )
        )
      );
  }
}