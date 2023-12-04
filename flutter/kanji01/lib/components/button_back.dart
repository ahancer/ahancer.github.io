import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          color: Styles.colorBlack,
          shape: BoxShape.circle
      ),
      child: Icon(Icons.chevron_left, color: Styles.colorWhite),
    );
  }
}
