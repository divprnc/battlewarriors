import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  List leaderboard = [];
  List solowinner = [];
  List duowinner = [];
  List squadwinner = [];
  List tdmwinner = [];
  List filtereLeaderBoard = [];
  String rank1, rank2, rank3;
  List duo = [];
  List squad = [];
  List tdm = [];
  bool isLoading = false;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("CompletedGames")
        .orderBy("GameData")
        .getDocuments();
    leaderboard = qn.documents.toList();
    for (int i = 0; i < leaderboard.length; i++) {
      var participants = leaderboard[i]["Participants"].toList();
      if (leaderboard[i]["Title"] == "Solo") {
        for (var j = 0; j < participants.length; j++) {
          if (participants[j]["Rank"] == 1) {
            rank1 = participants[j]["PubgId"];
          }
          if (participants[j]["Rank"] == 2) {
            rank2 = participants[j]["PubgId"];
          }
          if (participants[j]["Rank"] == 3) {
            rank3 = participants[j]["PubgId"];
          }
        }
        String cdate = leaderboard[i]["GameData"]["Date"];
        List dater = cdate.split("/").reversed.toList();
        String finalDate = dater.join('-');
        String ctime =
            leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
        String temptime = DateFormat.jm().parse(ctime).toString();
        List splitTime = temptime.split(" ");
        String finalDateAndTime = finalDate + " " + splitTime[1];
        solowinner.add({
          "Title": leaderboard[i]["Title"],
          "Date": leaderboard[i]["GameData"]["Date"],
          "Time": leaderboard[i]["GameData"]["Time"],
          "CompareTime": finalDateAndTime,
          "Rank1": rank1 != "" ? rank1 : "--",
          "Rank2": rank2 != "" ? rank2 : "--",
          "Rank3": rank3 != "" ? rank3 : "--",
        });
        rank1 = "";
        rank2 = "";
        rank3 = "";
      }
      if (leaderboard[i]["Title"] == "Duo") {
        for (var j = 0; j < participants.length; j++) {
          if (participants[j]["Rank"] == 1) {
            duo.add(participants[j]["PubgId"]);
          }
        }
        if (duo.length == 0) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          duowinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [],
            // "Player1": "--",
            // "Player2": "--",
          });
          duo.clear();
        }
        if (duo.length == 1) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          duowinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            'Players': [
              duo[0]
            ],
            "Player1": duo[0],
            // "Player2": "--",
          });
          duo.clear();
        }
        if (duo.length == 2) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          duowinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            'Players': [
              duo[0],
              duo[1],
            ],
            "Player1": duo[0],
            "Player2": duo[1],
          });
          duo.clear();
        }
      }
      if (leaderboard[i]["Title"] == "Squad") {
        for (var j = 0; j < participants.length; j++) {
          if (participants[j]["Rank"] == 1) {
            squad.add(participants[j]["PubgId"]);
          }
        }
        if (squad.length == 0) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          squadwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [],
            // "Player1": "--",
            // "Player2": "--",
            // "Player3": "--",
            // "Player4": "--",
          });
          squad.clear();
        }
        if (squad.length == 1) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          squadwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [squad[0] != null || squad[0] != "" ? squad[0] : "",],
            "Player1": squad[0] != null || squad[0] != "" ? squad[0] : "",
            // "Player2": "--",
            // "Player3": "--",
            // "Player4": "--",
          });
          squad.clear();
        }
        if (squad.length == 2) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          squadwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
            squad[0] != null || squad[0] != "" ? squad[0] : "",
            squad[1] != null || squad[1] != "" ? squad[1] : "",
              
            ],
            "Player1": squad[0] != null || squad[0] != "" ? squad[0] : "",
            "Player2": squad[1] != null || squad[1] != "" ? squad[1] : "",
            // "Player3": "--",
            // "Player4": "--",
          });
          squad.clear();
        }
        if (squad.length == 3) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          squadwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
          squad[0] != null || squad[0] != "" ? squad[0] : "",
          squad[1] != null || squad[1] != "" ? squad[1] : "",
          squad[2] != null || squad[2] != "" ? squad[2] : "",
            ],
            "Player1": squad[0] != null || squad[0] != "" ? squad[0] : "",
            "Player2": squad[1] != null || squad[1] != "" ? squad[1] : "",
            "Player3": squad[2] != null || squad[2] != "" ? squad[2] : "",
            // "Player4": "--",
          });
          squad.clear();
        }
        if (squad.length == 4) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          squadwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
              squad[0] != null || squad[0] != "" ? squad[0] : "",
            squad[1] != null || squad[1] != "" ? squad[1] : "",
            squad[2] != null || squad[2] != "" ? squad[2] : "",
            squad[3] != null || squad[3] != "" ? squad[3] : "",  
            ],
            "Player1": squad[0] != null || squad[0] != "" ? squad[0] : "",
            "Player2": squad[1] != null || squad[1] != "" ? squad[1] : "",
            "Player3": squad[2] != null || squad[2] != "" ? squad[2] : "",
            "Player4": squad[3] != null || squad[3] != "" ? squad[3] : "",
          });
          squad.clear();
        }
      }
      if (leaderboard[i]["Title"] == "TDM") {
        for (var j = 0; j < participants.length; j++) {
          if (participants[j]["Rank"] == 1) {
            tdm.add(participants[j]["PubgId"]);
          }
        }
        if (tdm.length == 0) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          tdmwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [],
          });
          tdm.clear();
        }
        if (tdm.length == 1) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          tdmwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
              {
                tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
              }
            ],
            "Player1": tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
            // "Player2": "--",
            // "Player3": "--",
            // "Player4": "--",
          });
          tdm.clear();
        }
        if (tdm.length == 2) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          tdmwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
              tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
              tdm[1] != null || tdm[1] != "" ? tdm[1] : "",

            ],
            "Player1": tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
            "Player2": tdm[1] != null || tdm[1] != "" ? tdm[1] : "",
            // "Player3": "--",
            // "Player4": "--",
          });
          tdm.clear();
        }
        if (tdm.length == 3) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          tdmwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
                tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
                tdm[1] != null || tdm[1] != "" ? tdm[1] : "",
                tdm[2] != null || tdm[2] != "" ? tdm[2] : "",
            ],
            "Player1": tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
            "Player2": tdm[1] != null || tdm[1] != "" ? tdm[1] : "",
            "Player3": tdm[2] != null || tdm[2] != "" ? tdm[2] : "",
            // "Player4": "--",
          });
          tdm.clear();
        }
        if (tdm.length == 4) {
          String cdate = leaderboard[i]["GameData"]["Date"];
          List dater = cdate.split("/").reversed.toList();
          String finalDate = dater.join('-');
          String ctime =
              leaderboard[i]["GameData"]["Time"].toString().toUpperCase();
          String temptime = DateFormat.jm().parse(ctime).toString();
          List splitTime = temptime.split(" ");
          String finalDateAndTime = finalDate + " " + splitTime[1];
          tdmwinner.add({
            "Title": leaderboard[i]["Title"],
            "Date": leaderboard[i]["GameData"]["Date"],
            "Time": leaderboard[i]["GameData"]["Time"],
            "CompareTime": finalDateAndTime,
            "Players": [
            tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
            tdm[1] != null || tdm[1] != "" ? tdm[1] : "",
            tdm[2] != null || tdm[2] != "" ? tdm[2] : "",
            tdm[3] != null || tdm[3] != "" ? tdm[3] : "",],
            "Player1": tdm[0] != null || tdm[0] != "" ? tdm[0] : "",
            "Player2": tdm[1] != null || tdm[1] != "" ? tdm[1] : "",
            "Player3": tdm[2] != null || tdm[2] != "" ? tdm[2] : "",
            "Player4": tdm[3] != null || tdm[3] != "" ? tdm[3] : "",
          });
          tdm.clear();
        }
      }
    }
    // String date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    // String cdate = tdmwinner.data[index].data["GameData"]["Date"];
    // List dater = cdate.split("/").reversed.toList();
    // String finalDate = dater.join('-');
    // String ctime = snapshot.data[index].data["GameData"]["Time"].toString().toUpperCase();
    // String temptime = DateFormat.jm().parse(ctime).toString();
    // // List splitTime = temptime.split(" ");
    // String finalDateAndTime = finalDate + " " + splitTime[1];
    tdmwinner.sort((a, b) {
      var adate = DateTime.parse(a['CompareTime']);
      var bdate = DateTime.parse(b['CompareTime']);
      return bdate.compareTo(adate);
      // return a.compareTo(b);
    });
    squadwinner.sort((a, b) {
      // return a.compareTo(b);
      var adate = DateTime.parse(a['CompareTime']);
      var bdate = DateTime.parse(b['CompareTime']);
      return bdate.compareTo(adate);
    });
    solowinner.sort((a, b) {
      // return a.compareTo(b);
      var adate = DateTime.parse(a['CompareTime']);
      var bdate = DateTime.parse(b['CompareTime']);
      return bdate.compareTo(adate);
    });
    duowinner.sort((a, b) {
      // return a.compareTo(b);
      var adate = DateTime.parse(a['CompareTime']);
      var bdate = DateTime.parse(b['CompareTime']);
      return bdate.compareTo(adate);
    });
    // tdmwinner.reversed;
    print(duowinner);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            labelStyle:
                TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                // icon: Icon(icon),
                icon: ImageIcon(AssetImage("assets/images/solo1.png")),
                text: "Solo",
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/images/duo1.png")),
                text: "Duo",
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/images/sqad1.png")),
                text: "Squad",
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/images/tdm1.png")),
                text: "Tdm",
              )
            ],
          ),
        ),
        body: TabBarView(
            children: [soloWinner(), duoWinner(), squadWinner(), tdmWinner()]),
      ),
    );
  }

  Widget soloWinner() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : solowinner.length == 0
            ? Center(
                child: Text("There are no recent winners"),
              )
            : ListView.builder(
                itemCount: solowinner.length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  solowinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + solowinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + solowinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/rank2.png",
                                  height: 50,
                                  width: 70,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  solowinner[index]["Rank2"],
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/rank1.png",
                                  height: 80,
                                  width: 100,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  solowinner[index]["Rank1"],
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/rank3.png",
                                  height: 50,
                                  width: 70,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  solowinner[index]["Rank3"],
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
  }

  Widget duoWinner() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : duowinner.length == 0
            ? Center(
                child: Text("There are no recent winners"),
              )
            : ListView.builder(
                itemCount: duowinner.length,
                itemBuilder: (_, index) {
                  if(duowinner[index]["Players"].length == 1) {
                    return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  duowinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + duowinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + duowinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/rank1.png",
                              color: Colors.orangeAccent,
                              height: 80,
                              width: 100,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                  duowinner[index]["Player1"] != " "
                                      ? duowinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       duowinner[index]["Player1"] != " "
                            //           ? duowinner[index]["Player1"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 50,
                            //     ),
                                // Text(
                                //   duowinner[index]["Player2"] != " "
                                //       ? duowinner[index]["Player2"]
                                //       : " ",
                                //   style: TextStyle(
                                //     color: Colors.deepOrangeAccent,
                                //     fontFamily: "Quicksand",
                                //   ),
                                // ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  );
                  }
                  if(duowinner[index]["Players"].length == 2) {
                      return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  duowinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + duowinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + duowinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/rank1.png",
                              color: Colors.orangeAccent,
                              height: 80,
                              width: 100,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  duowinner[index]["Player1"] != " "
                                      ? duowinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  duowinner[index]["Player2"] != " "
                                      ? duowinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  }else{
                    return Container();
                  }
                  // return Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueGrey.shade900,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.all(8),
                  //   height: MediaQuery.of(context).size.height * 0.33,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //             "Pubg Username of " +
                  //                 duowinner[index]["Title"] +
                  //                 " Winners",
                  //             style: TextStyle(
                  //                 color: Colors.deepOrangeAccent,
                  //                 fontFamily: "Quicksand",
                  //                 fontSize: 20)),
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "Date: " + duowinner[index]["Date"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //           Text(
                  //             "Time: " + duowinner[index]["Time"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Image.asset(
                  //             "assets/images/rank1.png",
                  //             color: Colors.orangeAccent,
                  //             height: 80,
                  //             width: 100,
                  //           ),
                  //           SizedBox(
                  //             height: 8,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 duowinner[index]["Player1"] != " "
                  //                     ? duowinner[index]["Player1"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: 50,
                  //               ),
                  //               Text(
                  //                 duowinner[index]["Player2"] != " "
                  //                     ? duowinner[index]["Player2"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // );
                });
  }

  Widget squadWinner() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : squadwinner.length == 0
            ? Center(
                child: Text("There are no recent winners"),
              )
            : ListView.builder(
                itemCount: squadwinner.length,
                itemBuilder: (_, index) {
                  if(squadwinner[index]["Players"].length == 1) {
                    return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  squadwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + squadwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + squadwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player1"] != " "
                                      ? squadwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                // Text(
                                //   squadwinner[index]["Player2"] != " "
                                //       ? squadwinner[index]["Player2"]
                                //       : " ",
                                //   style: TextStyle(
                                //     color: Colors.deepOrangeAccent,
                                //     fontFamily: "Quicksand",
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       squadwinner[index]["Player3"] != " "
                            //           ? squadwinner[index]["Player3"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //     Text(
                            //       squadwinner[index]["Player4"] != " "
                            //           ? squadwinner[index]["Player4"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  );
                  }if(squadwinner[index]["Players"].length == 2) {
                    return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  squadwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + squadwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + squadwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player1"] != " "
                                      ? squadwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  squadwinner[index]["Player2"] != " "
                                      ? squadwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       squadwinner[index]["Player3"] != " "
                            //           ? squadwinner[index]["Player3"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //     Text(
                            //       squadwinner[index]["Player4"] != " "
                            //           ? squadwinner[index]["Player4"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  );
                  }if(squadwinner[index]["Players"].length == 3) {
                    return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  squadwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + squadwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + squadwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player1"] != " "
                                      ? squadwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  squadwinner[index]["Player2"] != " "
                                      ? squadwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player3"] != " "
                                      ? squadwinner[index]["Player3"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                // Text(
                                //   squadwinner[index]["Player4"] != " "
                                //       ? squadwinner[index]["Player4"]
                                //       : " ",
                                //   style: TextStyle(
                                //     color: Colors.deepOrangeAccent,
                                //     fontFamily: "Quicksand",
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  }if(squadwinner[index]["Players"].length == 4) {
                    return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  squadwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + squadwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + squadwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player1"] != " "
                                      ? squadwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  squadwinner[index]["Player2"] != " "
                                      ? squadwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  squadwinner[index]["Player3"] != " "
                                      ? squadwinner[index]["Player3"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  squadwinner[index]["Player4"] != " "
                                      ? squadwinner[index]["Player4"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  }
                  else {
                    return Container();
                  }
                  // return Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueGrey.shade900,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.all(8),
                  //   height: MediaQuery.of(context).size.height * 0.33,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //             "Pubg Username of " +
                  //                 squadwinner[index]["Title"] +
                  //                 " Winners",
                  //             style: TextStyle(
                  //                 color: Colors.deepOrangeAccent,
                  //                 fontFamily: "Quicksand",
                  //                 fontSize: 20)),
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "Date: " + squadwinner[index]["Date"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //           Text(
                  //             "Time: " + squadwinner[index]["Time"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       Image.asset(
                  //         "assets/images/rank1.png",
                  //         height: 80,
                  //         width: 100,
                  //         color: Colors.orangeAccent,
                  //       ),
                  //       SizedBox(
                  //         height: 3,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 squadwinner[index]["Player1"] != " "
                  //                     ? squadwinner[index]["Player1"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //               Text(
                  //                 squadwinner[index]["Player2"] != " "
                  //                     ? squadwinner[index]["Player2"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 6,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 squadwinner[index]["Player3"] != " "
                  //                     ? squadwinner[index]["Player3"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //               Text(
                  //                 squadwinner[index]["Player4"] != " "
                  //                     ? squadwinner[index]["Player4"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // );
                });
  }

  Widget tdmWinner() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : tdmwinner.length == 0
            ? Center(
                child: Text("There are no recent winners"),
              )
            : ListView.builder(
                itemCount: tdmwinner.length,
                itemBuilder: (_, index) {
                  if(tdmwinner[index]['Players'].length == 1) {
                       return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  tdmwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + tdmwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + tdmwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player1"] != " "
                                      ? tdmwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                // Text(
                                //   tdmwinner[index]["Player2"] != " "
                                //       ? tdmwinner[index]["Player2"]
                                //       : " ",
                                //   style: TextStyle(
                                //     color: Colors.deepOrangeAccent,
                                //     fontFamily: "Quicksand",
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       tdmwinner[index]["Player3"] != " "
                            //           ? tdmwinner[index]["Player3"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //     Text(
                            //       tdmwinner[index]["Player4"] != " "
                            //           ? tdmwinner[index]["Player4"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  );
                  } 
                  if(tdmwinner[index]['Players'].length == 2){
                       return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  tdmwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + tdmwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + tdmwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player1"] != " "
                                      ? tdmwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  tdmwinner[index]["Player2"] != " "
                                      ? tdmwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       tdmwinner[index]["Player3"] != " "
                            //           ? tdmwinner[index]["Player3"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //     Text(
                            //       tdmwinner[index]["Player4"] != " "
                            //           ? tdmwinner[index]["Player4"]
                            //           : " ",
                            //       style: TextStyle(
                            //         color: Colors.deepOrangeAccent,
                            //         fontFamily: "Quicksand",
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  );
                  }
                  if(tdmwinner[index]['Players'].length == 3){
                       return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  tdmwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + tdmwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + tdmwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player1"] != " "
                                      ? tdmwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  tdmwinner[index]["Player2"] != " "
                                      ? tdmwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player3"] != " "
                                      ? tdmwinner[index]["Player3"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                // Text(
                                //   tdmwinner[index]["Player4"] != " "
                                //       ? tdmwinner[index]["Player4"]
                                //       : " ",
                                //   style: TextStyle(
                                //     color: Colors.deepOrangeAccent,
                                //     fontFamily: "Quicksand",
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  }
                  if(tdmwinner[index]['Players'].length == 4){
                       return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                              "Pubg Username of " +
                                  tdmwinner[index]["Title"] +
                                  " Winners",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontFamily: "Quicksand",
                                  fontSize: 20)),
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Date: " + tdmwinner[index]["Date"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                            Text(
                              "Time: " + tdmwinner[index]["Time"],
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          "assets/images/rank1.png",
                          height: 80,
                          width: 100,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player1"] != " "
                                      ? tdmwinner[index]["Player1"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  tdmwinner[index]["Player2"] != " "
                                      ? tdmwinner[index]["Player2"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tdmwinner[index]["Player3"] != " "
                                      ? tdmwinner[index]["Player3"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                                Text(
                                  tdmwinner[index]["Player4"] != " "
                                      ? tdmwinner[index]["Player4"]
                                      : " ",
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                  }
                  else {
                    return Container();
                  }
                  // return Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueGrey.shade900,
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.all(8),
                  //   height: MediaQuery.of(context).size.height * 0.33,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 8,
                  //       ),
                  //       Center(
                  //         child: Text(
                  //             "Pubg Username of " +
                  //                 tdmwinner[index]["Title"] +
                  //                 " Winners",
                  //             style: TextStyle(
                  //                 color: Colors.deepOrangeAccent,
                  //                 fontFamily: "Quicksand",
                  //                 fontSize: 20)),
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Text(
                  //             "Date: " + tdmwinner[index]["Date"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //           Text(
                  //             "Time: " + tdmwinner[index]["Time"],
                  //             style: TextStyle(
                  //               color: Colors.deepOrangeAccent,
                  //               fontFamily: "Quicksand",
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Divider(
                  //         color: Colors.deepOrangeAccent,
                  //       ),
                  //       SizedBox(
                  //         height: 15,
                  //       ),
                  //       Image.asset(
                  //         "assets/images/rank1.png",
                  //         height: 80,
                  //         width: 100,
                  //         color: Colors.orangeAccent,
                  //       ),
                  //       SizedBox(
                  //         height: 3,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 tdmwinner[index]["Player1"] != " "
                  //                     ? tdmwinner[index]["Player1"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //               Text(
                  //                 tdmwinner[index]["Player2"] != " "
                  //                     ? tdmwinner[index]["Player2"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 6,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 tdmwinner[index]["Player3"] != " "
                  //                     ? tdmwinner[index]["Player3"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //               Text(
                  //                 tdmwinner[index]["Player4"] != " "
                  //                     ? tdmwinner[index]["Player4"]
                  //                     : " ",
                  //                 style: TextStyle(
                  //                   color: Colors.deepOrangeAccent,
                  //                   fontFamily: "Quicksand",
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // );
                });
  }
}
