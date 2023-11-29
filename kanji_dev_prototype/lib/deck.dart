import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
// import 'package:login_email/quiz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LearnDeck extends StatefulWidget {
  final String UserID;
  final String ChapterTitle;
  final int ChapterID;
  final int ChapterLenght;

  const LearnDeck(
      {super.key,
      required this.UserID,
      required this.ChapterTitle,
      required this.ChapterID,
      required this.ChapterLenght});

  @override
  State<LearnDeck> createState() => _LearnDeckState();
}

class _LearnDeckState extends State<LearnDeck> {
  //Declare variable to get data from Supabse
  late Future<List<Map<String, dynamic>>> _myKanjisFuture;
  late List<Map<String, dynamic>> thisChapter;

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
        .eq('user_id', widget.UserID)
        .eq('chapter_id', widget.ChapterID);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgGray0,
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(widget.ChapterTitle,
              style: Styles.H2.copyWith(color: Styles.textColorWhite)),
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
              icon: Icon(Icons.delete, color: Styles.textColorWhite),
              onPressed: () {
                deleteKanjiData();
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
                //If there is no data in this chapter...
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await createNewKanji();
                        },
                        child: const Text(
                          'Unlock Chapter',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                //If there is data in this chapter...
                thisChapter = myKanji
                  ..sort((a, b) => a['kanji_id'].compareTo(b['kanji_id']));

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: thisChapter.length,
                          itemBuilder: (context, index) {
                            //Get the ID from this Result
                            int kanjiID = thisChapter[index]['kanji_id'];

                            //Trigger Get Score Function
                            int kanjiScore = getKanjiScore(kanjiID);

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
                                    thisKanji['kanji_id'],
                                    widget.ChapterLenght);
                              },
                              child: Card(
                                elevation:
                                    1.0, // Adjust elevation for shadow effect as needed
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        thisKanji['character'],
                                        style: Styles.jpSmall,
                                      ),
                                      const SizedBox(height: 8.0),
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text(
                          '+${widget.ChapterLenght} Words to Review',
                          style: Styles.textButton,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.bgAccent,
                          fixedSize: Size(358, 64.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                64.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      const SizedBox(height: 48.0),
                    ],
                  ),
                );
              }
            }));
  }

  void _showKanjiDetails(String character, String meaning, String reading,
      String hint, int id, int chapterLenght) {
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
                          left: 24, right: 24, top: 64, bottom: 40),
                      child: Container(
                        width: 320,
                        height: 440,
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

                            SizedBox(
                              height: 56,
                              width: 160,
                            ),

                            SizedBox(
                              width: 140,
                              height: 40, // Set the desired width
                              child: TextButton(
                                onPressed: () {
                                  if (id < thisChapter.last['kanji_id']) {
                                    updateKanjiDetails(id + 1);
                                  } else {
                                    updateKanjiDetails(id - chapterLenght + 1);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Next Kanji",
                                      style: Styles.body.copyWith(
                                          color: Styles.textColorGreen),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Styles.textColorGreen,
                                    ),
                                  ],
                                ),
                              ),
                            )
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

  int getRequiredScore() {
    int requiredScore = (widget.ChapterID - 1) * 3;
    return requiredScore;
  }

  //Get Score Function
  int getKanjiScore(int id) {
    return thisChapter.firstWhere((kanji) => kanji['kanji_id'] == id,
        orElse: () => {})['learn_score'];
  }

  // Create a list of new kanji data entries
  Future<void> createNewKanji() async {
    // Calculate the base kanji_id based on the ChapterID
    int baseKanjiId = 100 * widget.ChapterID;

    List<Map<String, dynamic>> newKanjis = [];
    for (int i = 1; i <= widget.ChapterLenght; i++) {
      newKanjis.add({
        'user_id': widget.UserID,
        'chapter_id': widget.ChapterID,
        'kanji_id': baseKanjiId + i,
        'learn_score': 0,
        'ready_time': '2023-10-23 10:00:00.000',
      });
    }

    // Use Supabase to insert new kanji data
    await Supabase.instance.client.from('my_kanjis').insert(newKanjis);

    // Refresh the state to reflect the new data
    setState(() {
      _myKanjisFuture = fetchData();
    });
  }

  //Delete Kanji Data of this chapter
  Future<void> deleteKanjiData() async {
    // Calculate the base kanji_id based on the ChapterID
    int baseKanjiId = 100 * widget.ChapterID;

    for (int i = 1; i <= widget.ChapterLenght; i++) {
      await Supabase.instance.client
          .from('my_kanjis')
          .delete()
          .eq('kanji_id', baseKanjiId + i)
          .eq(
              'chapter_id',
              widget
                  .ChapterID) // Ensuring we only delete kanjis for the current chapter
          .eq(
              'user_id',
              widget
                  .UserID); // Ensuring we only delete kanjis for the current user
    }

    setState(() {
      _myKanjisFuture = fetchData(); // Refresh the data
    });
  }
}
