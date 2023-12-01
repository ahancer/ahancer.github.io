import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/arcade.dart';
import 'package:kanji_prototype/exam.dart';
import 'package:kanji_prototype/level.dart';
import 'package:kanji_prototype/my_kanji.dart';
import 'package:kanji_prototype/utility.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? username;
  String? userid;
  late Future<List<Map<String, dynamic>>> _myKanjisFuture;
  late List<Map<String, dynamic>> thisReview;
  late Future<List<Map<String, dynamic>>> _myLevelFuture;
  late List<String> waitTimeList;

  //Init connection with Supabase
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _myKanjisFuture = fetchKanjiData();
    _myLevelFuture = fetchLevelData();
    waitTimeList = [];
  }

  _fetchUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      // Get User Email and UID
      setState(() {
        username = user.email;
        userid = user.id;
      });
    }
  }

  //Return data that have been filtered
  Future<List<Map<String, dynamic>>> fetchLevelData() async {
    final response = await Supabase.instance.client
        .from('my_level')
        .select<List<Map<String, dynamic>>>()
        .eq('user_id', userid);

    return List<Map<String, dynamic>>.from(response);
  }

  //Return Kanji data that have been filtered
  Future<List<Map<String, dynamic>>> fetchKanjiData() async {
    final response = await Supabase.instance.client
        .from('my_kanjis')
        .select<List<Map<String, dynamic>>>()
        .eq('user_id', userid);

    return List<Map<String, dynamic>>.from(response);
  }

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 24),
          end: Offset(0, 0),
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 600.ms,
          begin: Offset(0, -20),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgGray0,
        // appBar: AppBar(
        //   title: Text(username.toString()),
        //   automaticallyImplyLeading: false,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Supabase.instance.client.auth.signOut();
        //       Navigator.of(context).pushReplacementNamed('/');
        //     },
        //   ),
        //   actions: <Widget>[
        //       IconButton(
        //         icon: Icon(Icons.refresh),
        //         onPressed: () {
        //           Navigator.pushReplacement(
        //             context,
        //             PageRouteBuilder(
        //               pageBuilder: (context, animation1, animation2) => Home(),
        //               transitionDuration: Duration.zero,
        //             ),
        //           );
        //         },
        //       )
        //     ],
        //   ),

        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: _myKanjisFuture,
            builder: (context, snapshot) {
              // Add this check
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              //Get data from Supabase to local
              final myKanji = snapshot.data!;

              if (myKanji.isEmpty) {
                //If there is no data in this review...
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello AHA Team'),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                MyLevel(
                              userID: userid.toString(),
                            ),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text('Add Kanji'),
                    ),
                  ],
                ));
              } else {
                //If there is data in this chapter...
                thisReview = myKanji.toList(); //This version = no filter
                // thisReview = myKanji.where((kanji) => kanji['learn_score'] == 100).toList();
                thisReview.sort(
                    (a, b) => a['learn_score'].compareTo(b['learn_score']));

                //Set up date format and get the current time
                DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
                DateTime currentTime = DateTime.now();

                final myKanjiCount = thisReview.length;

                if (thisReview.isEmpty) {
                  return const Center(
                      child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          const SizedBox(height: 56.0),
                          Text('No word in your deck',
                              style: TextStyle(fontSize: 24)),
                        ],
                      )),
                    ],
                  ));
                } else {
                  for (int index = 0; index < thisReview.length; index++) {
                    // Get the ID from this Result
                    int kanjiID = thisReview[index]['kanji_id'];

                    // Trigger Get Functions
                    String kanjiReadyTime = getKanjiReadyTime(kanjiID);

                    // Parse the strings into DateTime objects
                    DateTime readyTime = format.parse(kanjiReadyTime);

                    // Calculate readyTime - currentTime
                    Duration difference = readyTime.difference(currentTime);

                    // Convert the difference to minutes for ease of reading
                    int differenceInMinutes = difference.inMinutes;
                    bool readyForReview = differenceInMinutes <= 0;

                    String timeString;

                    if (readyForReview) {
                      updateReviewStatus(kanjiID);
                      timeString = "Hit Refresh"; // Kanji is ready for review
                    } else if (differenceInMinutes > 60) {
                      // Convert minutes to hours and format the string
                      int hours = differenceInMinutes ~/ 60;
                      timeString = "$hours hr";
                    } else {
                      timeString = "$differenceInMinutes min";
                    }

                    //Add wait time to the list
                    waitTimeList.add(timeString);
                  }

                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 32.0),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16),
                          child: Row(
                            children: [
                              //Box1: Show Level and Exp
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: _myLevelFuture,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        }

                                        //Get data from Supabase to local
                                        final myData = snapshot.data!;

                                        if (myData.isEmpty) {
                                          return Text('myData is Empty');
                                        } else {
                                          //if we have data
                                          final int myLevel =
                                              myData[0]['level'];
                                          final int myExp = myData[0]['exp'];
                                          final int expCap = getExpCap(myLevel);
                                          final double progress =
                                              myExp / expCap;

                                          return InkWell(
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyLevel(
                                                          userID:
                                                              userid.toString(),
                                                        )),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 24),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Level ${myLevel}',
                                                          style:
                                                              Styles.subTitle),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  SizedBox(
                                                    child:
                                                        LinearProgressIndicator(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28),
                                                      value:
                                                          progress, // Current progress
                                                      backgroundColor: Styles
                                                          .bgGray1, // Background color of the progress bar
                                                      color: Styles
                                                          .bgAccent, // Color of the progress indicator
                                                      minHeight:
                                                          16, // Height of the progress bar
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                ),
                              ),

                              const SizedBox(width: 20.0),

                              //Box2: Total Words
                              Container(
                                height: 80,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Review(
                                                UserID: userid.toString())),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Total Learned',
                                            style: Styles.small.copyWith(
                                                color:
                                                    Styles.textColorSecondary),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            '$myKanjiCount words',
                                            style: Styles.body,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24.0),

                        //Dookdik + Cloud
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/home-header-bg.png',
                                width: MediaQuery.sizeOf(context).width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 48.0),
                                child: SizedBox(
                                  width: 180,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/img-home-mascot.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ).animateOnPageLoad(animationsMap[
                                      'imageOnPageLoadAnimation']!),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //Timer Content
                        Expanded(
                            child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (countReadyKanjis() > 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${countReadyKanjis()} words',
                                      style: Styles.H1,
                                    ),
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                Home(),
                                            transitionDuration: Duration.zero,
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/button_refresh.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  'Please come back in...',
                                  style: Styles.body,
                                ),
                              const SizedBox(height: 2.0),
                              if (countReadyKanjis() <= 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      waitTimeList[0].toString(),
                                      style: Styles.H1,
                                    ),
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                Home(),
                                            transitionDuration: Duration.zero,
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/button_refresh.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 4.0),
                              if (countReadyKanjis() > 0)
                                Text(
                                  'Ready to Review',
                                  style: TextStyle(fontSize: 16),
                                ),
                              const SizedBox(height: 20.0),
                              if (countReadyKanjis() > 0)
                                InkWell(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyExam(
                                                UserID: userid.toString(),
                                              )),
                                    );
                                  },
                                  child: const SizedBox(
                                    width: 68,
                                    height: 68,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/button_play.png'),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                              color: Styles.bgAccent,
                                            ),
                                            child: Center(
                                              child: Text('Review',
                                                  style: Styles.textButton),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          // Second inner container
                                          child: InkWell(
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation1,
                                                          animation2) =>
                                                      Arcade(
                                                    UserID: userid.toString(),
                                                  ),
                                                  transitionDuration:
                                                      Duration.zero,
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Text('Arcade',
                                                  style: Styles.textButton),
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
                        )),
                      ],
                    ),
                  );
                }
              }
            }));
  }

  //Count Kanji that is ready
  int countReadyKanjis() {
    int readyCount = 0;
    for (var kanji in thisReview) {
      if (kanji['review_status'] == 'Ready') {
        readyCount++;
      }
    }
    return readyCount;
  }

  //Get Score Function
  int getKanjiScore(int id) {
    return thisReview.firstWhere((kanji) => kanji['kanji_id'] == id,
        orElse: () => {})['learn_score'];
  }

  //Get Ready Time Function
  String getKanjiReadyTime(int id) {
    return thisReview.firstWhere((kanji) => kanji['kanji_id'] == id,
        orElse: () => {})['ready_time'];
  }

  //Update Review Status in Supabse
  Future<void> updateReviewStatus(int kanjiId) async {
    await Supabase.instance.client
        .from('my_kanjis')
        .update({'review_status': 'Ready'})
        .eq('kanji_id', kanjiId)
        .eq('user_id', userid);
  }
}
