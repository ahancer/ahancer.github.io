import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kanji01/components/button_primary.dart';
import 'package:kanji01/components/kanji_grid.dart';
import 'package:kanji01/screens/basic_deck_review.dart';
import '../components/button_back.dart';
import '../utils/app_data.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class BasicDeck extends StatelessWidget {
  const BasicDeck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);
    final deckSize = kanjiData.length;

    return Scaffold(
      backgroundColor: Styles.colorGreen,
      body: ListView(
        children: [

          //The Top Section
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Styles.colorPinkLight,
              image: const DecorationImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/images/img-deck-deco-top.png"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),

                  //The Back Button
                  const ButtonBack(),
                  const Gap(16),

                  //The Card Counter & Deck Name
                  Center(
                    child: Text(
                      "0/$deckSize",
                      style: Styles.fontH1,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Basic Kanji",
                      style: Styles.fontBody,
                    ),
                  ),

                  const Gap(20),

                  //The Review Button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BasicDeckReview()),
                        //TO DO: Add loading to load all the image assets before hand.
                      );
                    },
                    child: const ButtonPrimary(label: 'Review',),
                  ),
                  const Gap(32),

                  //The Kanji
                  const KanjiGrid(),
                  const Gap(8),
                ],
              )),
            ),
          ),

          //The Bottom Decoration
          SizedBox(
            child: Image.asset(
                'assets/images/img-deck-deco-bottom.png',
                alignment: Alignment.topCenter,
                fit: BoxFit.fill
            ),
          ),

      ],
      )
    );
  }
}
