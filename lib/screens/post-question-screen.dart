import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PostQuestionScreenWidget extends StatefulWidget {
  final bool isCorrect;
  final String uid;
  final int pointsGained;
  const PostQuestionScreenWidget(
      {Key? key,
      required this.uid,
      required this.isCorrect,
      required this.pointsGained})
      : super(key: key);

  @override
  _PostQuestionScreenWidgetState createState() =>
      _PostQuestionScreenWidgetState();
}

Future<Map<String, dynamic>> getUsersAndScores(String lobbyID) async {
  final databaseRef = FirebaseDatabase.instance.ref();
  Map<String, dynamic> usersInLobby = {};
  await databaseRef.child(lobbyID).once().then((DatabaseEvent event) {
    Map<dynamic, dynamic> lobbyData = event.snapshot.value as Map;
    if (lobbyData != null) {
      lobbyData.forEach((uid, userData) {
        if (uid.toString().substring(0, 3) == 'uid') {
          String nickname = userData['nickname'];
          int score = userData['score'];
          usersInLobby[uid] = {'nickname': nickname, 'score': score};
        }
        ;
      });
    }
  });
  return usersInLobby;
}

Map<String, dynamic> sort(Map<String, dynamic> usersAndScores) {
  List<MapEntry<String, dynamic>> usersList = usersAndScores.entries.toList();
  usersList.sort((a, b) => b.value['score'].compareTo(a.value['score']));
  usersAndScores = Map.fromEntries(usersList);
  return usersAndScores;
}

String getPlayerStatus(
    List<MapEntry<String, dynamic>> sortedEntries, String uid) {
  int index = -1;
  for (int i = 0; i < sortedEntries.length; i++) {
    MapEntry<String, dynamic> currentEntry = sortedEntries[i];
    if (currentEntry.key == uid) {
      index = i;
      break;
    }
  }
  //user uid not found. Fail gracefully.
  if (index == -1) {
    return "Better luck next time.";
  }
  //user is in first place
  if (index == 0) {
    return "You're in 1st place! Way to go Scrum Master!";
  } else {
    int competitorScore = sortedEntries[index - 1].value['score'];
    String competitor = sortedEntries[index - 1].value['nickname'];
    int thisPlayerScore = sortedEntries[index].value['score'];
    String scoreDifference = (competitorScore - thisPlayerScore).toString();
    String position = (index + 1).toString();
    return "Position: $position. You are $scoreDifference points behind $competitor";
  }
}

class _PostQuestionScreenWidgetState extends State<PostQuestionScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isCorrect ? Color(0xFF66BF39) : Color(0xFFFF3355),
      body: FutureBuilder<Map<String, dynamic>>(
          future: getUsersAndScores(
              '998765'), //------ hardcoded lobbyID. Will need to be changed
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> usersAndScores = snapshot.data!;
              Map<String, dynamic> usersAndScores_sorted = sort(usersAndScores);
              List<MapEntry<String, dynamic>> sortedEntries =
                  usersAndScores_sorted.entries.toList();
              String playerStatus = getPlayerStatus(sortedEntries, widget.uid);
              return buildPostQuestionScreen(playerStatus);
            } else if (snapshot.hasError) {
              return Center(child: Text("Error:  ${snapshot.error}"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  @override
  Widget buildPostQuestionScreen(String playerStatus) {
    final points = widget.pointsGained.toString();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.isCorrect ? Color(0xFF66BF39) : Color(0xFFFF3355),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.isCorrect ? "Correct!" : "Incorrect :(",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      widget.isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 200,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: widget.isCorrect
                              ? Color(0xFF26890C)
                              : Color(0xFFE21B3C),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.rectangle,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          '+ $points pts',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Text(
                        playerStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
