import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/exam_result.dart';
import 'package:kanji_prototype/my_kanji.dart';
import 'package:kanji_prototype/utility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyExam extends StatefulWidget {
  final String UserID;

  const MyExam({super.key, required this.UserID});

  @override
  State<MyExam> createState() => _MyExamState();
}

class _MyExamState extends State<MyExam> {
  //Change to Staeful and move query and shuffle up here
  late Future<List<Map<String, dynamic>>> _myKanjisFuture;
  late List<Map<String, dynamic>> thisExam;

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
    return FutureBuilder<List<Map<String, dynamic>>>(
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

          //Show only Kanji that has no delay time;
          thisExam = myKanji
              .where((kanji) => kanji['review_status'] == 'Ready')
              .toList();
          int maxItem = 10; //Now we set to 10

          if (thisExam.isEmpty) {
            //If no Kanji for Exam
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  title: const Text('Come Back Later'),
                ),
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Review(UserID: widget.UserID)),
                      );
                    },
                    child: const Text('Back to Review'),
                  ),
                ));
          } else {
            //Get shuffle the exam and cut down the list to the maxItem.
            thisExam.shuffle();
            if (thisExam.length > maxItem) {
              thisExam = thisExam.take(maxItem).toList();
            } else {
              maxItem = thisExam.length;
            }
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                'Review',
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
            ),
            backgroundColor: Colors.white,
            body: ExamQuestion(
              thisExam: thisExam,
              UserID: widget.UserID,
              maxItem: maxItem,
            ),
          );
        });
  }
}

class ExamQuestion extends StatefulWidget {
  final List<Map<String, dynamic>> thisExam;
  final String UserID;
  final int maxItem;

  const ExamQuestion(
      {super.key,
      required this.UserID,
      required this.thisExam,
      required this.maxItem});

  @override
  State<ExamQuestion> createState() => _ExamQuestionState();
}

class _ExamQuestionState extends State<ExamQuestion> {
  late int currentQuestionIndex;
  late int currentKanjiID;
  late Map<String, dynamic> thisKanji;
  bool isMeaningVisible = false;

  List<String> againList = []; // List to hold Kanji marked "Again"
  List<String> easyList = []; // List to hold Kanji marked "Easy"
  List<int> easyStreakList = []; // List to hold Kanji marked "Easy" Streak

  @override
  void initState() {
    super.initState();
    //Get the ID number of the first character in the shuffled list
    currentQuestionIndex = 0;
    currentKanjiID = widget.thisExam[currentQuestionIndex]['kanji_id'];

    //Copy a specific Kanji Data from the app_data
    thisKanji = kanjiData.firstWhere((k) => k['kanji_id'] == currentKanjiID);
  }

  @override
  Widget build(BuildContext context) {
    int currentQuestion = currentQuestionIndex + 1;
    int easyDelayTime =
        getEaseMultipler(widget.thisExam[currentQuestionIndex]['learn_score']);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$currentQuestion / ${widget.maxItem}',
                    style:
                        Styles.small.copyWith(color: Styles.textColorSecondary))
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 56.0),
                  if (isMeaningVisible)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              thisKanji['character'],
                              style: Styles.jpMedium,
                            ),
                            SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(thisKanji['reading'],
                                    style: Styles.subTitle),
                                SizedBox(height: 4),
                                Text(thisKanji['meaning'], style: Styles.H2),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Image.asset(
                          'assets/images/hint-$currentKanjiID.png',
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          child: Text(
                            thisKanji['hint'],
                            style: Styles.textHint,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 72.0),
                      ],
                    ),

                  // If the meaning is being show, go to the next question
                  if (isMeaningVisible)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Again Button
                        Expanded(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await updateMyKanji(
                                      0,
                                      widget.thisExam[currentQuestionIndex]
                                              ['learn_score'] *
                                          0); //Add 0 min delay & learnScore x 0
                                  setState(() {
                                    againList.add(thisKanji[
                                        'character']); // Add the current Kanji to the againList
                                    setNewIndex(context);
                                    isMeaningVisible = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Styles.bgHardBTN,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('Hard',
                                            style: Styles.textButton.copyWith(
                                                color: Styles.textColorWhite)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                child: Text(
                                  'Review Again',
                                  style: Styles.subBody
                                      .copyWith(color: Styles.textColorSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16.0),

                        Expanded(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  //Add multiplier for Easy button calculated by the number of Stars
                                  await updateMyKanji(
                                      easyDelayTime,
                                      widget.thisExam[currentQuestionIndex]
                                              ['learn_score'] +
                                          1); //Add 1xMultipler day delay & learnScore +1
                                  setState(() {
                                    easyList.add(thisKanji[
                                        'character']); // Add the current Kanji to the easyList
                                    easyStreakList.add(
                                        widget.thisExam[currentQuestionIndex]
                                                ['learn_score'] +
                                            1); //Add new streak recorder
                                    setNewIndex(context);
                                    isMeaningVisible = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Styles.bgEasyBTN,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('Easy',
                                            style: Styles.textButton.copyWith(
                                                color: Styles.textColorWhite)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                  '+${getEaseText(widget.thisExam[currentQuestionIndex]['learn_score'])}',
                                  style: Styles.subBody.copyWith(
                                      color: Styles.textColorSecondary)),
                            ],
                          ),
                        ),

                        // Easy Button
                      ],
                    ),

                  // If the meaning is hidden, show meaning
                  if (isMeaningVisible == false)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        Text(
                          thisKanji['character'],
                          style: Styles.jpLarge,
                        ),
                        SizedBox(height: 160),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isMeaningVisible = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.bgAccent,
                            fixedSize: Size(200, 64.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  64.0), // Adjust the radius as needed
                            ),
                          ),
                          child: Text(
                            'Show Meaning',
                            style: Styles.textButton.copyWith(color: Styles.textColorPrimary),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(height: 40.0),
                  // Text(
                  //     'Streak x${widget.thisExam[currentQuestionIndex]['learn_score']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Update ReadyTime function & Score
  Future<void> updateMyKanji(int addMinutes, int newScore) async {
    //Set limit score
    int clampedScore = newScore.clamp(0, 999);

    // Current time
    DateTime now = DateTime.now();
    // New ready time: current time + addMinutes
    DateTime newReadyTime = now.add(Duration(minutes: addMinutes));
    // Format the new ready time as a string
    String formattedReadyTime =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(newReadyTime);

    // Update 'ready_time' in Supabase database
    await Supabase.instance.client
        .from('my_kanjis')
        .update({
          'learn_score': clampedScore,
          'ready_time': formattedReadyTime,
          'review_status': 'Not Ready'
        })
        .eq('kanji_id', currentKanjiID)
        .eq('user_id', widget.UserID);
  }

  //To do: Fix number of item to X item.
  void setNewIndex(BuildContext context) {
    if (currentQuestionIndex < widget.thisExam.length - 1) {
      currentQuestionIndex += 1;
      currentKanjiID = widget.thisExam[currentQuestionIndex]['kanji_id'];
      thisKanji = kanjiData.firstWhere((k) => k['kanji_id'] == currentKanjiID);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ExamResult(
                    userID: widget.UserID,
                    againList: againList,
                    easyList: easyList,
                    easyStreakList: easyStreakList,
                  )));
      currentQuestionIndex = 0;
    }
  }
}
