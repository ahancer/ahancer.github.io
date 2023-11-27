import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';
import 'package:kanji_prototype/app_data.dart';
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
        title: Text('My Kanji'),
        actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
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
          
          if (myKanji.isEmpty){
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
                          pageBuilder: (context, animation1, animation2) => Home(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              )
            );
          } else {
            //If there is data in this chapter...
            thisReview = myKanji.toList(); //This version = no filter
            // thisReview = myKanji.where((kanji) => kanji['learn_score'] == 100).toList();
            thisReview.sort((a, b) => a['learn_score'].compareTo(b['learn_score']));

            //Set up date format and get the current time
            DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
            DateTime currentTime = DateTime.now();

            final myKanjiCount = thisReview.length;

            if (thisReview.isEmpty) {
              return const Center(
                child: Column(
                  children: [
                    Expanded(child: Column(
                      children: [
                        const SizedBox(height: 56.0),
                        Text('No Kanji in your deck',style: TextStyle(fontSize: 24)),
                      ],
                    )),
                    const SizedBox(height: 48.0),
                  ],
                )
              );
            } else {
                return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32.0),
                    Text(myKanjiCount.toString()+' Kanji',style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 24.0),

                    Expanded( 
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: thisReview.length,
                        itemBuilder: (context, index) {
                          
                          //Get the ID from this Result
                          int kanjiID = thisReview[index]['kanji_id'];

                          //Trigger Get Functions
                          int kanjiScore = getKanjiScore(kanjiID);
                          String kanjiReadyTime = getKanjiReadyTime(kanjiID);

                          // Parse the strings into DateTime objects
                          DateTime readyTime = format.parse(kanjiReadyTime);

                          // Calculate readyTime - currentTime
                          Duration difference = readyTime.difference(currentTime);

                          // Convert the difference to minutes for ease of reading
                          int differenceInMinutes = difference.inMinutes;
                          bool readyForReview = differenceInMinutes <= 0;        

                          //Update to Kanji status for ready Kanji
                          if (readyForReview) {
                            updateReviewStatus(kanjiID);
                          }          
                          
                          //Copy a specific Kanji Data from the app_data
                          Map<String, dynamic> thisKanji = kanjiData.firstWhere((k) => k['kanji_id'] == kanjiID);
              

                          return GestureDetector(
                            onTap: (){
                              _showKanjiDetails(thisKanji['character'], thisKanji['meaning'], thisKanji['reading'],thisKanji['hint'],thisKanji['kanji_id']);
                            },
                            child: Card(
                              elevation: 1.0, // Adjust elevation for shadow effect as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: readyForReview == false ? Colors.grey[200] : null, 
                              child: Container( 
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(thisKanji['character'],style: const TextStyle(fontSize: 28),),
                                    const SizedBox(height: 4.0),
                                    if(readyForReview) const Text(
                                      'Ready'
                                      ,style: TextStyle(color: Colors.green, fontSize: 12)
                                    ),
                                    if(!readyForReview) Text(
                                      'Wait ' + differenceInMinutes.toString() + ' min'
                                      ,style: TextStyle(color: Colors.grey, fontSize: 12)
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text('x$kanjiScore', style: TextStyle(color: Colors.grey, fontSize: 12),)
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
        }
      )



    );
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
    return thisReview.firstWhere((kanji) => kanji['kanji_id'] == id, orElse: () => {})['learn_score'];
  }

  //Get Ready Time Function
  String getKanjiReadyTime(int id) {
    return thisReview.firstWhere((kanji) => kanji['kanji_id'] == id, orElse: () => {})['ready_time'];
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
  void _showKanjiDetails(String character, String meaning, String reading, String hint, int id) {
  showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              // Function to update the Kanji Details
              void updateKanjiDetails(int newId) {
                  setState(() {
                    character = kanjiData.firstWhere((k) => k['kanji_id'] == newId)['character'];
                    meaning = kanjiData.firstWhere((k) => k['kanji_id'] == newId)['meaning'];
                    reading = kanjiData.firstWhere((k) => k['kanji_id'] == newId)['reading'];
                    hint = kanjiData.firstWhere((k) => k['kanji_id'] == newId)['hint'];
                    id = newId;
                  });
              }

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();  // Close the modal
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, 
                        mainAxisAlignment: MainAxisAlignment.center, 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Text(character,style: TextStyle(fontSize: 100),textAlign: TextAlign.center,),
                          SizedBox(height: 12), 
                          Text("($reading)"),
                          SizedBox(height: 12),
                          Text(meaning),
                          SizedBox(height: 16),
                          Divider(color: Colors.grey[300]),
                          SizedBox(height: 16),
                          Image.asset('assets/images/hint-$id.png', height: 100, fit: BoxFit.contain,),
                          SizedBox(height: 8),
                          Text(hint,style: TextStyle(fontSize: 14), textAlign: TextAlign.center,),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }
}
