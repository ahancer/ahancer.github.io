import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/app_styles.dart';
import 'package:kanji_prototype/deck.dart';
import 'package:kanji_prototype/home.dart';
import 'package:kanji_prototype/utility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyLevel extends StatefulWidget {
  final String userID;

  const MyLevel({super.key, required this.userID});

  @override
  State<MyLevel> createState() => _MyLevelState();
}

class _MyLevelState extends State<MyLevel> {
  late Future<List<Map<String, dynamic>>> _myLevelFuture;

  //Init a function to connenct with Supabase
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgGray0,
      appBar: AppBar(
         title: const Text('My Level'),
         automaticallyImplyLeading: false,
         actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Home(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
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
              
              if(myData.isEmpty){
                return Text('myData is Empty');
              } else{
                //if we have data
                final int myLevel = myData[0]['level'];
                final int myExp = myData[0]['exp'];
                final int expCap = getExpCap(myLevel);
                final double progress = myExp/expCap;

                return Column(
                  children: [
                    const SizedBox(height: 24.0),
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
                            children: [
                              Text('Level: ${myLevel} (Exp: ${myExp}/${expCap})', style: TextStyle(fontSize: 20),),
                              LinearProgressIndicator(
                                value: progress, // Current progress
                                backgroundColor: Colors.grey[300], // Background color of the progress bar
                                color: Colors.blue, // Color of the progress indicator
                                minHeight: 16, // Height of the progress bar
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: resetLevel, child: Text('Reset Level')),
                        const SizedBox(width: 16.0),
                        TextButton(onPressed: () => skipLevel(myLevel), child: Text('Skip Level')),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                          itemCount: chapterData.length,
                          itemBuilder: (context, index) {
                            
                            final chapterId = chapterData[index]['chapter_id'];
                            final isUnlocked = chapterId <= myLevel;
                            final chapterLenght = chapterData[index]['chapter_lenght'];
                            final isCurrentLevel = chapterId == myLevel;

                            return GestureDetector(
                              onTap: isUnlocked ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LearnDeck(
                                      ChapterTitle:chapterData[index]['chapter_name'],
                                      ChapterID: chapterId,
                                      UserID: widget.userID,
                                      ChapterLenght: chapterLenght,
                                    ),
                                  ),
                                );
                              } : () {
                                // Provide feedback to the user that the chapter is locked.
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('Lv.' + chapterId.toString() + ' ' + chapterData[index]['chapter_name'],style: const TextStyle(fontSize: 16)),
                                    subtitle: Text(isUnlocked ? '$chapterLenght Words' : 'Locked'),
                                    tileColor: isUnlocked ? Colors.white : const Color.fromARGB(255, 187, 187, 187),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: isCurrentLevel ? Colors.blue : Colors.white,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            );
                          },
                          ),
                        ),
                    ),
                  ],
                );

              }
              
            }
          ),           
    );
  }

  Future<void> resetLevel() async {
    await Supabase.instance.client
        .from('my_level')
        .update({'level': 1, 'exp': 0})
        .eq('user_id', widget.userID);

    // Trigger a rebuild to show updated level and exp
    setState(() {
      _myLevelFuture = fetchData();
    });
  }

  Future<void> skipLevel(int currentLevel) async {
    int nextLevel = currentLevel+1;
    await Supabase.instance.client
        .from('my_level')
        .update({'level': nextLevel, 'exp': 0})
        .eq('user_id', widget.userID);

    // Trigger a rebuild to show updated level and exp
    setState(() {
      _myLevelFuture = fetchData();
    });
  }

}