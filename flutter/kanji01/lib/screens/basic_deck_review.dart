import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../components/button_back.dart';
import '../components/button_primary.dart';
import '../components/kanji_side_answer.dart';
import '../components/kanji_side_question.dart';
import '../utils/app_data.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class BasicDeckReview extends StatelessWidget {
  const BasicDeckReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);

    return Scaffold(
        backgroundColor: Styles.colorPink,
        body: ListView(
        children: [
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img-review-bg.png'),
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat,
                alignment: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),

                  //The Back Button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const ButtonBack(),
                  ),

                  const Gap(16),

                  //The Kanji Card
                  KanjiCard(),
                ],
              ),
            )
          )
        ]
      )
    );
  }
}

class KanjiCard extends StatefulWidget {

  const KanjiCard({Key? key}) : super(key: key);

  @override
  _KanjiCardState createState() => _KanjiCardState();
}

class _KanjiCardState extends State<KanjiCard> {

  bool _isFirstObject = true;
  bool _isOnAnswerSide = false;

  final deckSize = kanjiData.length;
  String kanjiToReview = kanjiData[0]['character']; //TO DO: Add random character index function here

  void _toggleObject() {
    setState(() {
      //Change the card side
      _isFirstObject = !_isFirstObject;

      //Show the next card when on the Answer Side
      if (_isOnAnswerSide){

        //Get a random kanji for the next character
        final random = Random();
        final randomNumber = random.nextInt(deckSize);
        kanjiToReview = kanjiData[randomNumber]['character']; //TO DO: Don't select the same character

        //Change the state back to the Question Side
        _isOnAnswerSide = false;

        //TO DO: Add a counter to count the number of card reviewed and end the review session after unique 6 characters
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
        onTap: _toggleObject,
        child: _isFirstObject
            ? Column(
          //The Question Side of the Card
            children: [
              KanjiSideQuestion(kanjiForThisCard: kanjiToReview),
              const Gap(32),
              //The Flip Button
              const ButtonPrimary(label: "Flip"),
            ]
        )
            : Column(
            //The Answer Side of the Card
            children: [
              KanjiSideAnswer(kanjiForThisCard: kanjiToReview),
              const Gap(32),
            //The Hard vs. Easy Buttons
              InkWell(onTap: () {
                _isOnAnswerSide = true;
                _toggleObject();
              },child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Expanded(child: ButtonPrimary(label: "😥  Hard")), // NOT FINISH HERE
                  Gap(16),
                  Expanded(child: ButtonPrimary(label: "😁  Easy")), // NOT FINISH HERE
                ],
              ),
            )
          ],
        )
    );
  }
}
