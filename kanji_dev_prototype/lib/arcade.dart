import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
import 'package:kanji_prototype/matching.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Arcade extends StatefulWidget {
  final String UserID;

  const Arcade(
    {super.key,
    required this.UserID,
    });

  @override
  State<Arcade> createState() => _ArcadeState();
}

class _ArcadeState extends State<Arcade> {
  //Declare variable to get data from Supabse
  late Future<List<Map<String, dynamic>>> _myKanjisFuture;

  //Create a list to recieve the data and pass to the game
  List<Map<String, String>> thisRound = [
    {
      'character':'Waiting-1',
      'meaning':'Waiting-1',
      'matching':'default'
    },
    {
      'character':'Waiting-2',
      'meaning':'Waiting-2',
      'matching':'default'
    },
    {
      'character':'Waiting-3',
      'meaning':'Waiting-3',
      'matching':'default'
    },
    {
      'character':'Waiting-4',
      'meaning':'Waiting-4',
      'matching':'default'
    },
    {
      'character': 'Waiting-5',
      'meaning': 'Waiting-5',
      'matching':'default'
    },
  ];

  //Init a function to connenct with Supabase
  @override
  void initState() {
    super.initState();
    _myKanjisFuture = fetchData();
  }

  //Return data that have been filtered
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await Supabase.instance.client
        .from('my_kanjis')
        .select<List<Map<String, dynamic>>>()
        .eq('user_id', widget.UserID);

    return List<Map<String, dynamic>>.from(response);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgWhite,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _myKanjisFuture,
        builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        //Get data from Supabase to local
        final myKanji = snapshot.data!;

        if (myKanji.length < thisRound.length) {
          //If there is no data...
          return const Center(child:Text('Please Unlock Chapter 1'));
        } else {
          //If there is data... shuffle and copy the first 5 character to thisRound
          myKanji.shuffle;
          for (int i = 0; i < thisRound.length; i++) {
            if (i < thisRound.length) {

              int theID = myKanji[i]['kanji_id'];
              String character = kanjiData.firstWhere((k) => k['kanji_id'] == theID)['character'];
              String meaning = kanjiData.firstWhere((k) => k['kanji_id'] == theID)['meaning'];

              thisRound[i]['character'] = character;
              thisRound[i]['meaning'] = meaning;
            }
          }

          return Column(
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
                    MaterialPageRoute(builder: (context) => MatchingGame(UserID: widget.UserID.toString(), thisRound: thisRound,)),
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
          );
        }
        }
      ),
    );
  }
}