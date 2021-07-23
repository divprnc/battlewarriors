import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyContest extends StatefulWidget {
  @override
  _MyContestState createState() => _MyContestState();
}

class _MyContestState extends State<MyContest> {
  bool isLoading = false;
  bool personalAccountController;
  bool allAccountController;
  List gameidsArray = [];
  List gameidslist = [];
  Map gameData = {};
  Map roomData = {};
  String title = "";
  List temp = [];
  List contests = [];
  List completedArray = [];
  // List completedList = []
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            labelStyle: TextStyle(
               fontFamily: "Quicksand", fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.trending_down),
                text: "Joined",
              ),
              Tab(
                icon: Icon(Icons.check_circle),
                text: "Completed",
              )
            ],
          ),
        ),
        body: TabBarView(children: [joinedContest(), completedContest()]),
      ),
    );
  }
  Future<void> fetchUserjoinedcontestids() async {
    setState(() {
      isLoading = true;
    });
          FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
            await Firestore.instance
          .collection('UserJoinedGame')
          .document('$authid')
          .get()
          .then((dss) {
            if(dss.exists) {
              gameidsArray = dss.data["JoinedGames"].reversed.toList();
            }
      }).then((value) => {
              gameidsArray.forEach((element) { 
        element.forEach((key,value) {
          gameidslist.add(value);
        });
      })
      }).then((value)  async{
        print(gameidslist);
        await fetchUsergameData();
      });

      
      setState(() {
        isLoading = false;
      });
  }


    Future<void> fetchUsergameData() async {
    setState(() {
      isLoading = true;
    });
      for(int i = 0; i<gameidslist.length; i++) {
                await Firestore.instance.collection("LiveGames").document(gameidslist[i]).get().then((snapshot) => {
            temp.add(snapshot.data)
        });
      }
      setState(() {
        isLoading = false;
      });
  }

  Future<void>  fetchCompleted() async {
       setState(() {
      isLoading = true;
    });
          FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
            await Firestore.instance
          .collection('UserCompletedGame')
          .document('$authid')
          .get()
          .then((dss) {
            if(dss.exists) {
              completedArray = dss.data["CompletedGames"].reversed.toList();
            }
      }).then((value) => {
      }).then((value)  async{
      });
      setState(() {
        isLoading = false;
      });
  }

    Future<void> getaccountControl() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('UserAccountControl')
        .document('Account')
        .get()
        .then((dss) {
      if (dss.exists) {
        allAccountController = dss.data["UserAccount"];
      }
    });
        await Firestore.instance
        .collection('UserAccountControl')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        personalAccountController = dss.data["Action"];
      }
    });
    print(allAccountController);print(personalAccountController);
        setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserjoinedcontestids();
    fetchCompleted();
    getaccountControl();
  }
  Widget joinedContest() {
    return isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : temp.length == 0 ? Center(child: Text("No Game Joined Yet.....", style: TextStyle(
            fontFamily: "Quicksand",
            fontSize:18,
          ),),) : ListView.builder(
            itemCount: temp.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Container(
      margin: EdgeInsets.all(5),
      height: 280,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.blueGrey.shade800,
            ),
            height: 150,
            width: double.infinity,
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(temp[index]["Title"],style: TextStyle(
                          color: Colors.white,
                          fontSize: 22, fontFamily: "Quicksand", fontWeight: FontWeight.bold,
                        ),)
                      ],
                    ),
                    
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Date",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(temp[index]["GameData"]["Date"],
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Time",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(temp[index]["GameData"]["Time"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Map",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(temp[index]["GameData"]["MapName"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Mode",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(temp[index]["GameData"]["Mode"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        )
                      ],
                    ),

                    Divider(
                      color: Colors.white,
                    ),
                    allAccountController == true && personalAccountController == true ? Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Per Kill",
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                              Text("₹ " + temp[index]["GameData"]["PerKill"].toString(),
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                            SizedBox(
                              height: 5,
                            ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Entry Fees",
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                              Text("₹ " + temp[index]["GameData"]["Entryfees"].toString(),
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                            SizedBox(
                              height: 5,
                            ),
                            ],
                          ),
                        ],
                      ),
                    ) : Container(),
                  ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                  color: Colors.orange,
            ),
            child: Padding(
                  padding: const EdgeInsets.only(top:6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                          Text("Room Id",
                              style: TextStyle(
                                color: Colors.white, fontFamily: "Quicksand",
                              )),
                          Text(temp[index]["Room"]["Id"] == "" ? "--" : temp[index]["Room"]["Id"] ,
                              style: TextStyle(
                                color: Colors.black, fontFamily: "Quicksand",
                              ))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                          Text("Room Password",
                              style: TextStyle(
                                color: Colors.white, fontFamily: "Quicksand",
                              )),
                          Text(temp[index]["Room"]["Password"] == "" ? "--" : temp[index]["Room"]["Password"],
                              style: TextStyle(
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ],
                  ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Text("Room Id and Password will appear here before 15 minutes of match.", style: TextStyle(
                      color: Colors.white, fontFamily: "Quicksand",
                      fontSize: 11
                    )),
                ),
              ),
          )
        ],
      ),
    ),
                ],
              );
            },
          );
  }

  Widget completedContest() {
    return isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : completedArray.length == 0 ? Center(child: Text("Completed Games results will\ndisplayed here.....", style: TextStyle(
            fontFamily: "Quicksand",
            fontSize:18,
          ),),) : ListView.builder(
            itemCount: completedArray.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Container(
      margin: EdgeInsets.all(5),
      height: 280,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.blueGrey.shade800,
            ),
            height: 150,
            width: double.infinity,
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(completedArray[index]["Title"],style: TextStyle(
                          color: Colors.white,
                          fontSize: 22, fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Date",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(completedArray[index]["Date"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Time",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(completedArray[index]["Time"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Map",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(completedArray[index]["MapName"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text("Mode",
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                            Text(completedArray[index]["Mode"],
                                style: TextStyle(
                                  color: Colors.white, fontFamily: "Quicksand",
                                )),
                          ],
                        )
                      ],
                    ),

                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Per Kill",
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                              Text("₹ " + completedArray[index]["PerKill"].toString(),
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                            SizedBox(
                              height: 5,
                            ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Entry Fees",
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                              Text("₹ "   + completedArray[index]["Entryfees"].toString(),
                                  style: TextStyle(
                                    color: Colors.white, fontFamily: "Quicksand",
                                  )),
                            SizedBox(
                              height: 5,
                            ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                  color: Colors.orange,
            ),
            child: Padding(
                  padding: const EdgeInsets.only(top:6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                          Text("Rank",
                              style: TextStyle(
                                color: Colors.white, fontFamily: "Quicksand",
                              )),
                          Text(completedArray[index]["Rank"].toString(),
                              style: TextStyle(
                                color: Colors.black, fontFamily: "Quicksand",
                              ))
                        ],
                      ),
                      Column(
                        children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                          Text("Kill",
                              style: TextStyle(
                                color: Colors.white, fontFamily: "Quicksand",
                              )),
                          Text(completedArray[index]["Kill"].toString(),
                              style: TextStyle(
                                color: Colors.black, fontFamily: "Quicksand",
                              ))
                        ],
                      ),
                    ],
                  ),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            ),
            child: Center(
                  child: Text(" Winning Amount is added to your wallet    ", style: TextStyle(
                    color: Colors.white, fontFamily: "Quicksand",
                  )),
            ),
          )
        ],
      ),
    ),
                ],
              );
            },
          );
  }
}
