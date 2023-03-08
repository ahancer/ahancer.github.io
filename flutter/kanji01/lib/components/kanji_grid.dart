import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_styles.dart';
import 'kanji_grid_item.dart';

class KanjiGrid extends StatelessWidget {
  const KanjiGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        crossAxisCount: 3,
        children: const <Widget>[
          KanjiGridItem(kanji: '山'),
          KanjiGridItem(kanji: '口'),
          KanjiGridItem(kanji: '日'),
          KanjiGridItem(kanji: '川'),
          KanjiGridItem(kanji: '田'),
          KanjiGridItem(kanji: '木'),
          KanjiGridItem(kanji: '水'),

        ],
      ),
    );
  }
}
