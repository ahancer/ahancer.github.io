import 'package:flutter/material.dart';
import 'package:kanji_prototype/app_data.dart';
import 'package:kanji_prototype/home.dart';
// import 'package:login_email/quiz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LearnDeck extends StatefulWidget {
  final String UserID;
  final String ChapterTitle;
  final int ChapterID;
  final int ChapterLenght;

  const LearnDeck({super.key, required this.UserID, required this.ChapterTitle, required this.ChapterID, required this.ChapterLenght});

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
        .eq('chapter_id',widget.ChapterID);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.ChapterTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
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
          
          if (myKanji.isEmpty){
            //If there is no data in this chapter...
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await createNewKanji();
                    },
                    child: const Text('Unlock Chapter', style: TextStyle(fontSize: 32),),
                  ),
                ],
              ),
            );
          } else {
            //If there is data in this chapter...
            thisChapter = myKanji..sort((a, b) => a['kanji_id'].compareTo(b['kanji_id']));
          
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),

                  Expanded( 
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        Map<String, dynamic> thisKanji = kanjiData.firstWhere((k) => k['kanji_id'] == kanjiID);
                        
                        return GestureDetector(
                          onTap: (){
                            _showKanjiDetails(thisKanji['character'], thisKanji['meaning'], thisKanji['reading'],thisKanji['hint'],thisKanji['kanji_id'],widget.ChapterLenght);
                          },
                          child: Card(
                            elevation: 1.0, // Adjust elevation for shadow effect as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container( 
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(thisKanji['character'],style: const TextStyle(fontSize: 28),),
                                  const SizedBox(height: 4.0),
                                  Text('x$kanjiScore', style: TextStyle(fontSize: 12)),
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
                    child: Text('+${widget.ChapterLenght} Words to Review', style: TextStyle(fontSize: 32),),
                  ),
                  const SizedBox(height: 48.0),
                ],
              ),
            );
          }
        }
      )
    );
  }

  void _showKanjiDetails(String character, String meaning, String reading, String hint, int id, int chapterLenght) {
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
                          TextButton(
                          child: Text("Next Kanji"),
                          onPressed: () {
                              if (id < thisChapter.last['kanji_id']) {
                                updateKanjiDetails(id + 1);
                              } else {
                                updateKanjiDetails(id - chapterLenght + 1);
                              }
                            },
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
      }
    );
  }

  int getRequiredScore(){
    int requiredScore = (widget.ChapterID -1)*3;
    return requiredScore;
  }

  //Get Score Function
  int getKanjiScore(int id) {
    return thisChapter.firstWhere((kanji) => kanji['kanji_id'] == id, orElse: () => {})['learn_score'];
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
        'ready_time':'2023-10-23 10:00:00.000',
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
    await Supabase.instance.client.from('my_kanjis')
      .delete()
      .eq('kanji_id', baseKanjiId + i)
      .eq('chapter_id', widget.ChapterID) // Ensuring we only delete kanjis for the current chapter
      .eq('user_id', widget.UserID); // Ensuring we only delete kanjis for the current user
  }

  setState(() {
    _myKanjisFuture = fetchData(); // Refresh the data
  });
}
}

