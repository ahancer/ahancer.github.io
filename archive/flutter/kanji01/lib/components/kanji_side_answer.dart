import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/app_data.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class KanjiSideAnswer extends StatelessWidget {
  const KanjiSideAnswer({Key? key, required this.kanjiForThisCard}) : super(key: key);

  final String kanjiForThisCard;

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);
    final cardHeight = size.height * 0.66;

    String kanjiCharacter = kanjiForThisCard;
    Map<String, dynamic> thisKanji = kanjiData.where((p) => p['character'] == kanjiCharacter).first;

    String kanjiTranslation = thisKanji['translation'];
    String kanjiSentence = thisKanji['sentence'];
    String kanjiImage = thisKanji['image'];

    return Container(
      width: size.width,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Styles.colorWhite,
      ),
      child: Column(
        children: [
          const Gap(0),
          SizedBox(
            child: Image.asset(
                'assets/images/$kanjiImage',
                alignment: Alignment.topCenter,
                fit: BoxFit.fill
            ),
          ),
          const Gap(16),
          Text(
            kanjiTranslation,
            style: Styles.fontH3,
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.only(left: 24.0,right: 24.0),
            child: Text(
              kanjiSentence,
              textAlign: TextAlign.center,
              style: Styles.fontSmall,
            ),
          ),
        ],
      ),
    );
  }
}
