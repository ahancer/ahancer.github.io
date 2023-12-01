import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/matching_lose.dart';
import 'package:kanji_prototype/matching_win.dart';

class MatchingGame extends StatefulWidget {
  final String UserID;
  final List<Map<String, String>> thisRound; 

  const MatchingGame(
    {super.key,
      required this.UserID,
      required this.thisRound,
    });

  @override
  State<MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {

  // Temp Data for Dry Run
  // List<Map<String, String>> matchingData = [
  //   {
  //     'character':'日',
  //     'meaning':'Sun',
  //     'matching':'default'
  //   },
  //   {
  //     'character':'月',
  //     'meaning':'Moon',
  //     'matching':'default'
  //   },
  //   {
  //     'character':'土',
  //     'meaning':'Soil',
  //     'matching':'default'
  //   },
  //   {
  //     'character':'川',
  //     'meaning':'River',
  //     'matching':'default'
  //   },
  //   {
  //     'character': '山',
  //     'meaning': 'Mountain',
  //     'matching':'default'
  //   },
  // ];

  late List<Map<String, String>> characterData;
  late List<Map<String, String>> meaningData;
  String selectedCharacter = "N/A";
  String selectedMeaning = "N/A";
  int selectedCharacterIndex = -1;
  int selectedMeaningIndex = -1;
  int heart = 3;
  int countCorrect = 0;

  Timer? _timer;
  int _totalTime = 150; // 15 Seconds
  int _remainingTime = 150;

  @override
  void initState() {
    super.initState();

    // Clone the original data into characterData and meaningData
    characterData = List<Map<String, String>>.from(widget.thisRound);
    meaningData = List<Map<String, String>>.from(widget.thisRound);

    // Shuffle each list independently
    characterData.shuffle();
    meaningData.shuffle();
      
    //Start Timer
    startTimer();
  }

  void startTimer() {
  _remainingTime = _totalTime;
  _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (_remainingTime > 0) {
      setState(() {
        _remainingTime--;
      });
    } else {
      _timer?.cancel();
      onTimerComplete();
    }
  });
  }

  void onTimerComplete() {
    // Time out = You Lose
    // Show a Snackbar for incorrect match
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Styles.bgHardBTN,
        content: Text('Time Out!', style: Styles.title,),
        duration: Duration(seconds: 1),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MatchingLose(UserID: widget.UserID.toString(),)),
    );
  }

  @override
    void dispose() {
      _timer?.cancel();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set value for progress bar
    double progress = _remainingTime / _totalTime;

    return Scaffold(
      backgroundColor: Styles.bgGray1,
      body: Column(
        children: [

          //Top Nav and hearts
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Styles.bgHardBTN),
                    Text(' x $heart', style: Styles.subTitle,),
                    const SizedBox(width: 8.0),
                  ],
                ),
              ],
            ),
          ),

          //Progress bar
          Padding(
            padding: const EdgeInsets.only(top:4, bottom:20, left:24, right:24),
            child: LinearProgressIndicator(
              borderRadius:
                  BorderRadius.circular(
                      28),
              value:
                  progress, // Current progress
              backgroundColor: Styles
                  .bgGray2, // Background color of the progress bar
              color: Styles
                  .bgAccent, // Color of the progress indicator
              minHeight:
                  16, // Height of the progress bar
            ),
          ),

          //Game Part
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Row 1: Character
                Expanded(
                  child: Column(
                    children: List.generate(characterData.length, (index) {
                      String matchingCharacterStatus = characterData[index]['matching'].toString();
                
                      Color tileColor;
                      Function()? onTapAction;
                
                      switch (matchingCharacterStatus) {
                        case 'correct':
                          tileColor = Styles.textColorGreen;
                          onTapAction = () {}; // No action 
                          break;
                        case 'default':
                        default:
                          tileColor = index == selectedCharacterIndex ? Styles.bgGray2 : Colors.white;
                          onTapAction = () => selectCharacter(characterData[index]['character'].toString(), index);
                          break;
                      }
                
                      return Padding(
                        padding:  const EdgeInsets.only(left: 24, top: 16, right: 8, bottom: 0),
                        child: GestureDetector(
                          onTap: onTapAction,
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: tileColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                characterData[index]['character'].toString(),
                                style: Styles.H1.copyWith(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                //Row 2: Meaning   
                Expanded(
                  child: Column(
                    children: List.generate(meaningData.length, (index) {
                      String matchingMeaningStatus = meaningData[index]['matching'].toString();

                      Color tileColor;
                      Function()? onTapAction;

                      switch (matchingMeaningStatus) {
                        case 'correct':
                          tileColor = Styles.textColorGreen;
                          onTapAction = () {}; // No action 
                          break;
                        case 'default':
                        default:
                          tileColor = index == selectedMeaningIndex ? Styles.bgGray2 : Colors.white;
                          onTapAction = () => selectMeaning(meaningData[index]['character'].toString(), index);
                          break;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(left: 8, top: 16, right: 24, bottom: 0),
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: onTapAction,
                            child: Center(child: Text(meaningData[index]['meaning'].toString(), style: Styles.subTitle,textAlign: TextAlign.center,)),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

              ]
            ),
          )
        ]
      )
    );
  }

  void selectCharacter(String character, int index) {
    setState(() {
      selectedCharacter = character;
      selectedCharacterIndex = index;
      if(selectedMeaning == 'N/A'){
        print('Wait for Meaning...');
      } else {
        print('Check Matching...');
        checkMatch();
      }
    });
  }

  void selectMeaning(String meaning, int index) {
    setState(() {
      selectedMeaning = meaning;
      selectedMeaningIndex = index;
      if(selectedCharacter == 'N/A'){
        print('Wait for Character...');
      } else {
        print('Check Matching...');
        checkMatch();
      }
    });
  }

  void checkMatch() {
    setState(() {
      if (selectedCharacter == selectedMeaning) {
        // It's a match
        characterData[selectedCharacterIndex]['matching'] = 'correct';
        meaningData[selectedMeaningIndex]['matching'] = 'correct';
        countCorrect++;
        print('Match found!');

        if (countCorrect == widget.thisRound.length) {
          // You Win
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MatchingWin(UserID: widget.UserID.toString(),)),
          );
        }
      } else {
        // Not a match
        characterData[selectedCharacterIndex]['matching'] = 'default';
        meaningData[selectedMeaningIndex]['matching'] = 'default';
        heart--;

         // Show a Snackbar for incorrect match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Styles.bgHardBTN,
            content: Text('Incorrect! Heart -1.', style: Styles.title,),
            duration: Duration(seconds: 1),
          ),
        );

        print('Not a match.');
        if (heart <= 0) {
          // You Lose
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MatchingLose(UserID: widget.UserID.toString(),)),
          );
        }
      }

      // Reset selections
      selectedCharacter = "N/A";
      selectedMeaning = "N/A";
      selectedCharacterIndex = -1;
      selectedMeaningIndex = -1;
    });
}
}