import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Review extends StatefulWidget {
  final String UserID;

  const Review({super.key, required this.UserID});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  //Declare variable to get data from Supabse
  late Future<List<Map<String, dynamic>>> _myKanjisFuture;
  late List<Map<String, dynamic>> thisReview;

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
        appBar: AppBar(
          title: Text(
            'My Kanji',
            style: Styles.H2.copyWith(color: Styles.textColorWhite),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Styles.bgWhite,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Styles.textColorWhite,
              ),
              onPressed: () {
                Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
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
                    Text('No Kanji Data'),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                Home(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: const Text('Go Back'),
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
                          Text('No Kanji in your deck',
                              style: TextStyle(fontSize: 24)),
                        ],
                      )),
                      const SizedBox(height: 48.0),
                    ],
                  ));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 32.0),
                        Text(myKanjiCount.toString() + ' Kanji',
                            style: Styles.H2),
                        const SizedBox(height: 24.0),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 0.84,
                            ),
                            itemCount: thisReview.length,
                            itemBuilder: (context, index) {
                              //Get the ID from this Result
                              int kanjiID = thisReview[index]['kanji_id'];

                              //Trigger Get Functions
                              int kanjiScore = getKanjiScore(kanjiID);
                              String kanjiReadyTime =
                                  getKanjiReadyTime(kanjiID);

                              // Parse the strings into DateTime objects
                              DateTime readyTime = format.parse(kanjiReadyTime);

                              // Calculate readyTime - currentTime
                              Duration difference =
                                  readyTime.difference(currentTime);

                              // Convert the difference to minutes for ease of reading
                              int differenceInMinutes = difference.inMinutes;
                              bool readyForReview = differenceInMinutes <= 0;

                              //Update to Kanji status for ready Kanji
                              if (readyForReview) {
                                updateReviewStatus(kanjiID);
                              }

                              //Copy a specific Kanji Data from the app_data
                              Map<String, dynamic> thisKanji = kanjiData
                                  .firstWhere((k) => k['kanji_id'] == kanjiID);

                              return GestureDetector(
                                onTap: () {
                                  _showKanjiDetails(
                                      thisKanji['character'],
                                      thisKanji['meaning'],
                                      thisKanji['reading'],
                                      thisKanji['hint'],
                                      thisKanji['kanji_id']);
                                },
                                child: Card(
                                  elevation:
                                      1.0, // Adjust elevation for shadow effect as needed
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  color: readyForReview == false
                                      ? Styles.bgGray2
                                      : null,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(thisKanji['character'],
                                            style: Styles.jpSmall),
                                        SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.thumb_up_outlined,
                                              color: Styles.textColorSecondary,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text('x$kanjiScore',
                                                style: Styles.subBody.copyWith(
                                                    color: Styles
                                                        .textColorSecondary)),
                                          ],
                                        ),
                                        SizedBox(height: 12.0),
                                        if (readyForReview)
                                          Text('Ready',
                                              style: Styles.small.copyWith(
                                                  color:
                                                      Styles.textColorGreen)),
                                        if (!readyForReview)
                                          Text(
                                              'Wait ' +
                                                  differenceInMinutes
                                                      .toString() +
                                                  ' min',
                                              style: Styles.small.copyWith(
                                                  color: Styles
                                                      .textColorSecondary)),
                                        const SizedBox(height: 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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

  //Count total stars
  int sumTotalStars() {
    int scoreSum = 0;
    for (var kanji in thisReview) {
      scoreSum += (kanji['learn_score'] as num?)?.toInt() ?? 0;
    }
    return scoreSum;
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
        .eq('user_id', widget.UserID);
  }

  //Show Modal
  void _showKanjiDetails(
      String character, String meaning, String reading, String hint, int id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              // Function to update the Kanji Details
              void updateKanjiDetails(int newId) {
                setState(() {
                  character = kanjiData
                      .firstWhere((k) => k['kanji_id'] == newId)['character'];
                  meaning = kanjiData
                      .firstWhere((k) => k['kanji_id'] == newId)['meaning'];
                  reading = kanjiData
                      .firstWhere((k) => k['kanji_id'] == newId)['reading'];
                  hint = kanjiData
                      .firstWhere((k) => k['kanji_id'] == newId)['hint'];
                  id = newId;
                });
              }

              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the modal
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 64, bottom: 24),
                      child: Container(
                        width: 320,
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  character,
                                  style: Styles.jpMedium,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reading,
                                      style: Styles.subTitle,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      meaning,
                                      style: Styles.H2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // Divider(color: Colors.grey[300]),
                            SizedBox(height: 16),
                            Image.asset(
                              'assets/images/hint-$id.png',
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 40,
                              child: Text(
                                hint,
                                style: Styles.body,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
