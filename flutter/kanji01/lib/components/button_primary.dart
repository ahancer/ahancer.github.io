import 'package:flutter/cupertino.dart';
import '../utils/app_styles.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Styles.colorBlack,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            label,
            style: Styles.fontBodyBold.copyWith(color: Styles.colorWhite),
          ),
        ),
      ),
    );
  }
}
