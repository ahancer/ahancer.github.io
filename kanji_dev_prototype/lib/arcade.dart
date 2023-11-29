import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
import 'package:kanji_prototype/matching.dart';

class Arcade extends StatelessWidget {
  const Arcade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Banner Image
          const Image(
            image: AssetImage('assets/images/img-arcade-banner.png'),
            alignment: Alignment.center,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 32.0),
          Text('Lets toast', style: Styles.H1,),
          Text('your memory!', style: Styles.H1,),
          const SizedBox(height: 32.0),
          Text('Match Kanji words that you have ', style: Styles.subTitle,),
          const SizedBox(height: 4.0),
          Text('learned with their meanings.', style: Styles.subTitle,),
          const SizedBox(height: 40.0),
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent, 
            highlightColor: Colors.transparent, 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MatchingGame()),
              );
            },
            child: const SizedBox(
              width: 68,
              height: 68,
              child: Image(
                image: AssetImage('assets/images/button_play.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          const SizedBox(height: 64.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  color: Styles.bgGray0,
                ),
                height: 68,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // First inner container
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent, 
                          highlightColor: Colors.transparent, 
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => Home(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Center(
                            child: Text('Review', style: Styles.textButton),
                          ),
                        ),
                      ),
                      Expanded(
                        // Second inner container
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Styles.bgAccent,
                          ),
                          child: Center(
                            child: Text('Arcade', style: Styles.textButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48.0),
        ],
      ),
    );
  }
}