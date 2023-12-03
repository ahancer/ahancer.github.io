import 'package:flutter/material.dart';
import '../screens/basic_deck_preview.dart';
import '../utils/app_styles.dart';

class KanjiGridItem extends StatelessWidget {
  const KanjiGridItem({Key? key, required this.kanji}) : super(key: key);

  final String kanji;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BasicDeckPreview(kanjiToReview: kanji)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Styles.colorWhite,
        ),
        child: Center(
            child: Text(
              kanji,
              style: Styles.fontKanjiSmall,
            )
        ),
      ),
    );
  }
}
