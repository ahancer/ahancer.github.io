import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/matching_lose.dart';
import 'package:kanji_prototype/matching_win.dart';

class MatchingGame extends StatefulWidget {
  const MatchingGame({super.key});

  @override
  State<MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {

  List<Map<String, String>> matchingData = [
    {
      'character':'日',
      'meaning':'Sun',
      'matching':'default'
    },
    {
      'character':'月',
      'meaning':'Moon',
      'matching':'default'
    },
    {
      'character':'土',
      'meaning':'Soil',
      'matching':'default'
    },
    {
      'character':'川',
      'meaning':'River',
      'matching':'default'
    },
    {
      'character': '山',
      'meaning': 'Mountain',
      'matching':'default'
    },
  ];

  late List<Map<String, String>> characterData;
  late List<Map<String, String>> meaningData;
  String selectedCharacter = "N/A";
  String selectedMeaning = "N/A";
  int selectedCharacterIndex = -1;
  int selectedMeaningIndex = -1;
  int heart = 3;
  int countCorrect = 0;

  @override
  void initState() {
    super.initState();

    // Clone the original data into characterData and meaningData
    characterData = List<Map<String, String>>.from(matchingData);
    meaningData = List<Map<String, String>>.from(matchingData);

    // Shuffle each list independently
    characterData.shuffle();
    meaningData.shuffle();
  }

  @override
  Widget build(BuildContext context) {
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

          //Game Part
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Row 1: Character
                Expanded(
                  child: ListView.builder(
                    itemCount: characterData.length,
                    itemBuilder: (context, index) {
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
                        padding: const EdgeInsets.only(left: 32, top: 16, right: 8, bottom: 0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical:32.0),
                            child: Center(child: Text(characterData[index]['character'].toString(), style: Styles.subTitle)),
                          ),
                          onTap: onTapAction,
                          tileColor: tileColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //Row 2: Meaning   
                 Expanded(
                  child: ListView.builder(
                    itemCount: meaningData.length,
                    itemBuilder: (context, index) {
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
                        padding: const EdgeInsets.only(left: 8, top: 16, right: 32, bottom: 0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical:32.0),
                            child: Center(child: Text(meaningData[index]['meaning'].toString(), style: Styles.subTitle)),
                          ),
                          onTap: onTapAction,
                          tileColor: tileColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],         
            ),
          ),

        ],
      ),
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

        if (countCorrect == matchingData.length) {
          // You Win
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MatchingWin()),
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
            MaterialPageRoute(builder: (context) => MatchingLose()),
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