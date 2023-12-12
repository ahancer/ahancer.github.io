import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/home.dart';
import 'package:kanji_prototype/level.dart';
import 'package:kanji_prototype/utility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExamResult extends StatefulWidget {
  final String userID;
  final List<String> againList;
  final List<String> easyList;
  final List<int> easyStreakList;

  const ExamResult(
      {super.key,
      required this.userID,
      required this.againList,
      required this.easyList,
      required this.easyStreakList});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  late Future<List<Map<String, dynamic>>> _myLevelFuture;
  bool _levelUp = false; // Added this to track level up
  int _getExp = 0;

  //Init a function to connenct with Supabase
  @override
  void initState() {
    super.initState();
    // Fetch data and then update the level
    fetchData().then((data) {
      if (data.isNotEmpty) {
        // Trigger updateLevel after the initial data is fetched
        int bonus = widget.easyStreakList
                .fold(0, (previousValue, element) => previousValue + element) *
            2; //Bonus = Sum of all Streaks x 2
        _getExp = (widget.againList.length * 1) +
            (widget.easyList.length * 3) +
            bonus; //Scoring Logic x1 x3 + Bonus
        updateLevel(_getExp);
      }
    }).catchError((error) {
      // Handle any errors from fetchData here
      print('Failed to fetch data: $error');
    });

    // Assign the future to the variable for use in FutureBuilder
    _myLevelFuture = fetchData();
  }

  //Return data that have been filtered
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await Supabase.instance.client
        .from('my_level')
        .select<List<Map<String, dynamic>>>()
        .eq('user_id', widget.userID);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> updateLevel(int addExp) async {
    final currentData = await fetchData();
    if (currentData.isEmpty) {
      throw Exception('No data found for user');
    }
    final currentLevel = currentData[0]['level'];
    final currentExp = currentData[0]['exp'];

    int expCap = getExpCap(currentLevel);
    int newExp = currentExp + addExp;
    int newLevel = currentLevel;

    if (newExp >= expCap) {
      newLevel += 1;
      newExp -= expCap;
      _levelUp = true;
    }

    await Supabase.instance.client.from('my_level').update(
        {'level': newLevel, 'exp': newExp}).eq('user_id', widget.userID);

    // Trigger a rebuild to show updated level and exp
    setState(() {
      _myLevelFuture = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgGray0,
        appBar: AppBar(
          title: Text(
            'Review Complete',
            style: Styles.H2.copyWith(color: Styles.textColorWhite),
          ),
          automaticallyImplyLeading: false, // This will hide the back button
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Styles.textColorWhite,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            )
          ],
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: _myLevelFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              //Get data from Supabase to local
              final myData = snapshot.data!;

              if (myData.isEmpty) {
                return Text('myData is Empty');
              } else {
                //if we have data
                final int myLevel = myData[0]['level'];
                final int myExp = myData[0]['exp'];
                final int expGoal = getExpCap(myLevel);
                final double progress = myExp / expGoal;

                return Column(children: [
                  const SizedBox(height: 24.0),

                  //Level Scale
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Level ${myLevel}',
                                    style: Styles.title,
                                  ),
                                  Expanded(
                                      child: Text(
                                    '+' + _getExp.toString() + ' Exp',
                                    style: Styles.subBody
                                        .copyWith(color: Styles.textColorGreen),
                                    textAlign: TextAlign.right,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(28),
                                value: progress, // Current progress
                                backgroundColor: Styles
                                    .bgGray1, // Background color of the progress bar
                                color: Styles
                                    .bgAccent, // Color of the progress indicator
                                minHeight: 16, // Height of the progress bar
                              ),
                            ],
                          ),
                        )),
                  ),

                  //-------Level Scale 4.0 Version--------
                  // Text(
                  //   'Level: ${myLevel}',
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // // Text('Level: ${myLevel} (Exp: ${myExp}/${expGoal})', style: TextStyle(fontSize: 20),),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: LinearProgressIndicator(
                  //     value: progress,
                  //     backgroundColor: Colors.grey[300],
                  //     color: Colors.blue,
                  //     minHeight: 16,
                  //   ),
                  // ),

                  const SizedBox(height: 32.0),

                  if (!_levelUp)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.bgAccent,
                        fixedSize: Size(358, 64.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              64.0), // Adjust the radius as needed
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: Text(
                        'Back Home',
                        style: Styles.textButton
                            .copyWith(color: Styles.textColorPrimary),
                      ),
                    ),
                  if (_levelUp)
                    const Text('Congratulations! You have leveled up!'),
                  const SizedBox(height: 32.0),
                  if (_levelUp)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.bgAccent,
                        fixedSize: Size(358, 64.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              64.0), // Adjust the radius as needed
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyLevel(userID: widget.userID.toString())),
                        );
                      },
                      child: Text(
                        'Unlock new content',
                        style: Styles.textButton
                            .copyWith(color: Styles.textColorPrimary),
                      ),
                    ),
                  const SizedBox(height: 24.0),

                  if (widget.easyList.isNotEmpty)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text('${widget.easyList.length} easy words!',
                              style: Styles.title),
                        )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 120, // Define the height of the scrollable area
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.easyList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100, // Define the width of each item
                            child: Card(
                              elevation: 1.0,
                              color: Styles.bgWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.easyList[index],
                                        style: Styles.jpSmall),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          color: Styles.textColorSecondary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text(
                                            'x${widget.easyStreakList[index]}',
                                            style: Styles.small.copyWith(color: Styles.textColorSecondary)),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    // Text(
                                    //     'Wait ${getEaseText(widget.easyStreakList[index] - 1)}',
                                    //     style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16.0),
                  if (widget.againList.isNotEmpty)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                              '${widget.againList.length} words to review again.',
                              style: Styles.title),
                        )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 120, // Define the height of the scrollable area
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.againList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100, // Define the width of each item
                            child: Card(
                              elevation: 1.0,
                              color: Styles.textColorWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.againList[index],
                                        style: Styles.jpSmall),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          color: Styles.textColorSecondary,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 2.0),
                                        Text('x0', style: Styles.small.copyWith(color: Styles.textColorSecondary,)),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    // Text('Wait 0m',
                                    //     style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]);
              }
            }));
  }
}
