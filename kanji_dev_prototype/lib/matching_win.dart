import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/arcade.dart';

class MatchingWin extends StatefulWidget {
  final String UserID;

  const MatchingWin(
  {super.key,
    required this.UserID,
  });

  @override
  State<MatchingWin> createState() => _MatchingWinState();
}

class _MatchingWinState extends State<MatchingWin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgGray0,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Styles.bgGray0,
          elevation: 0,
          automaticallyImplyLeading: false, // This will hide the back button
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Arcade(UserID: widget.UserID.toString()))
                );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/images/img-matching-win.png'),
                alignment: Alignment.center,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Expanded(
                  child: Container(
                color: Styles.bgWhite,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 48),
                    Text('Good Job!',
                        style:
                            Styles.H1.copyWith(color: Styles.textColorPrimary)),
                    SizedBox(height: 12),
                    Text(
                      'Your word recall is impressive!',
                      style: Styles.subTitle
                          .copyWith(color: Styles.textColorPrimary),
                    ),
                    SizedBox(height: 80),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.bgAccent,
                        fixedSize: Size(220, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              64.0), // Adjust the radius as needed
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Arcade(UserID: widget.UserID.toString()))
                        );
                      },
                      child: Text(
                        'Back to Arcade',
                        style: Styles.textButton
                            .copyWith(color: Styles.textColorPrimary),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}
