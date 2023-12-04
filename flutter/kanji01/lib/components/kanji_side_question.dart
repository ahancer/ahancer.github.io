import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import '../utils/app_data.dart';
import '../utils/app_layout.dart';
import '../utils/app_styles.dart';

class KanjiSideQuestion extends StatelessWidget {

  const KanjiSideQuestion({Key? key, required this.kanjiForThisCard}) : super(key: key);

  final String kanjiForThisCard;

  @override
  Widget build(BuildContext context) {

    final size = AppLayout.getSize(context);
    final cardHeight = size.height * 0.66;

    String kanjiCharacter = kanjiForThisCard;

    Map<String, dynamic> thisKanji = kanjiData.where((p) => p['character'] == kanjiCharacter).first;

    String kanjiKun = thisKanji['Kun'];
    String kanjiOn = thisKanji['On'];

    return Container(
      width: size.width,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Styles.colorWhite,
      ),
      child: Column(
        children: [
          const Gap(80),
          Text(
            kanjiCharacter,
            style: Styles.fontKanjiBig,
          ),
          const Gap(96),
          Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Kun.  ",
                    style: Styles.fontSmall.copyWith(color: Styles.colorGrey),
                  ),
                  TextSpan(
                    text: kanjiKun,
                    style: Styles.fontSmall,
                  )
                ],
              )
          ),
          const Gap(4),
          Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "On.  ",
                    style: Styles.fontSmall.copyWith(color: Styles.colorGrey),
                  ),
                  TextSpan(
                    text: kanjiOn,
                    style: Styles.fontSmall,
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
