import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../components/button_back.dart';
import '../components/button_primary.dart';
import '../components/kanji_side_answer.dart';
import '../components/kanji_side_question.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class BasicDeckPreview extends StatelessWidget {
  const BasicDeckPreview({Key? key, required this.kanjiToReview}) : super(key: key);
  final String kanjiToReview;

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);

    return Scaffold(
        backgroundColor: Styles.colorYellow,
        body: ListView(
        children: [
          Padding(
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
                KanjiCard(kanji: kanjiToReview),
              ],
            ),
          )
        ]
      )
    );
  }
}


class KanjiCard extends StatefulWidget {

  const KanjiCard({Key? key, required this.kanji}) : super(key: key);
  final String kanji;

  @override
  _KanjiCardState createState() => _KanjiCardState();
}

class _KanjiCardState extends State<KanjiCard> {

  bool _isFirstObject = true;

  void _toggleObject() {
    setState(() {
      _isFirstObject = !_isFirstObject;
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
              KanjiSideAnswer(kanjiForThisCard: widget.kanji),
              const Gap(32),
              //The Flip Button
              const ButtonPrimary(label: "Flip"),
            ]
        )
            : Column(
          //The Answer Side of the Card
          children: [
            KanjiSideQuestion(kanjiForThisCard: widget.kanji),
            const Gap(32),
            //The Flip Button
            const ButtonPrimary(label: "Flip"),
          ],
        )
    );
  }
}
