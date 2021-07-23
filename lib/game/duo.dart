import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/profile_edit.dart';
import 'package:intl/intl.dart';
class DuoPage extends StatefulWidget {
  @override
  _DuoPageState createState() => _DuoPageState();
}

class _DuoPageState extends State<DuoPage> {
  int showdeposit, showwin;
  int countpaidTransaction;
  String appliedCode;
  bool mine;
  Future<void> getWallets() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    await Firestore.instance
        .collection('UserTransactions')
        .document('$uid')
        .get()
        .then((dss) {
      if (dss.exists) {
        showdeposit = dss.data["DepositAmount"];
        showwin = dss.data["WinningAmount"];
        countpaidTransaction = dss.data['CountTrans'];
      }
    });

    
    await Firestore.instance
        .collection('ReferalCodes')
        .document('$uid')
        .get()
        .then((dss) {
      if (dss.exists) {
        appliedCode = dss.data["appliedcode"];
        mine = dss.data["mine"];
      }
    });
  }
  bool allAccountController;
  bool isLoading = false;
  List alreadyJoined = [];
  List alreadyJoinedArray = [];
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String pubgid;
  String uid;
  int walletAmount;
  int winningWallet;
  List transactions = [];
  String gameid;
  String againgameId;
  List participants = [];
  int remainingSeats;
  int totalFees;
  int deductedBalance;
  List joinedGames = [];
  String type;
  String gtime, gdate, gmap, gmode, gtype;
  int gtotal, gkill, gentry;
  Future<List<DocumentSnapshot>> getData() async {
await Firestore.instance
        .collection('UserAccountControl')
        .document('Account')
        .get()
        .then((dss) {
      if (dss.exists) {
        allAccountController = dss.data["Game"];
      }
    });
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("LiveGames")
        .where("Title", isEqualTo: "Duo")
        .getDocuments();
    return qn.documents;
  }

  Future<void> alreadyJoinedGames() async {
        setState(() {
      isLoading = true;
    });
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    await Firestore.instance
        .collection('UserJoinedGame')
        .document('$uid')
        .get()
        .then((dss) {
      if (dss.exists) {
        alreadyJoined = dss.data["JoinedGames"];
      }
    }).then((value) {
          alreadyJoined.forEach((element) {
      element.forEach((k, v) {
        if (!alreadyJoinedArray.contains(v)) {
          alreadyJoinedArray.add(v);
        }
      });
    });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    alreadyJoinedGames();
    getWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Duo", style: TextStyle(fontFamily: "Quicksand"),),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : FutureBuilder(
        future: getData(),
        builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: SpinKitCircle(
                      color: Colors.blueGrey.shade900,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            );
          }else if(snapshot.data.isEmpty){
                  return Center(
                    child: Text("Currently no active games are here...",style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 18
                    ),),
                  );
                }
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                String cdate = snapshot.data[index].data["GameData"]["Date"];
                List dater = cdate.split("/").reversed.toList();
                String finalDate = dater.join('-');
                String ctime = snapshot.data[index].data["GameData"]["Time"].toString().toUpperCase();
                String date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
                String temptime = DateFormat.jm().parse(ctime).toString();
                List splitTime = temptime.split(" "); 
                String finalDateAndTime = finalDate + " " + splitTime[1];
                int compare = DateTime.parse(finalDateAndTime).difference(DateTime.parse(date)).inSeconds;
                  if(compare < 0) {
                            return Container();
                  }
                  else{
                      return Container(
                    margin: EdgeInsets.all(10),
                    height: 185,
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
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                height: 6,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Date",
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot.data[index]
                                                .data["GameData"]["Date"],
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
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
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot.data[index]
                                                .data["GameData"]["Time"],
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
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
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot.data[index]
                                                    .data["GameData"]
                                                ["MapName"],
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
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
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot.data[index]
                                                .data["GameData"]["Mode"],
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Total Seats",
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot
                                                .data[index]
                                                .data["GameData"]
                                                    ["TotalSeats"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                      ],
                                    ),
                                    allAccountController == true?Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Winning",
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Expanded(
                                            child: FlatButton(
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 18,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.orange
                                                            .shade500,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                      topLeft:
                                                          Radius.circular(
                                                              15),
                                                      topRight:
                                                          Radius.circular(
                                                              15),
                                                    )),
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        child: snapshot.data[index]
                                                .data["GameData"]["Type"].toString() == "Free" ? Container(
                                                  
                                                  height: 100,
                                                  child: Center(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      SizedBox(height: 5,),
                                                      Text("Winning Prizes", style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Quicksand"
                                                      )),
                                                      Divider(
                                                        color: Colors.white,
                                                        height: 2,
                                                      ),
                                                      Center(child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text("First Rank Team ", style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),),
                                                          Text("₹ " + snapshot.data[index].data["Prize"]["RankFirst"].toString(), style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),)
                                                        ],
                                                      ),),
                                                    ],
                                                  ),)
                                                ) : Container(
                                                  padding: EdgeInsets.only(
                                                    top:5
                                                  ),
                                                  height: 150,
                                                  child: Center(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      Text("Winning Prizes", style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Quicksand"
                                                      )),
                                                      Divider(
                                                        color: Colors.white,
                                                        height: 2,
                                                      ),
                                                      Center(child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text("First Rank Team", style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),),
                                                          Text("₹ " + snapshot.data[index].data["Prize"]["RankFirst"].toString(), style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),)
                                                        ],
                                                      ),),
                                                      Divider(
                                                        color: Colors.white,
                                                        height: 2,
                                                      ),
                                                      Center(child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text("Each Team Rank 2-10", style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),),
                                                          Text("₹ " + snapshot.data[index].data["Prize"]["Rank_2_to_10"].toString(), style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,fontFamily: "Quicksand"
                                                          ),)
                                                        ],
                                                      ),),
                                                    ],
                                                  ),)
                                                )
                                                      );
                                                    },
                                                  );
                                                }))
                                      ],
                                    ) : Container(),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Remaining Seats",
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                        Text(
                                            snapshot
                                                .data[index]
                                                .data["GameData"]
                                                    ["RemainingSeats"]
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "Quicksand"
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              allAccountController == true?Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("Per Kill",
                                              style: TextStyle(
                                                color: Colors.white,fontFamily: "Quicksand"
                                              )),
                                          Text(
                                              "₹ " +
                                                  snapshot
                                                      .data[index]
                                                      .data["GameData"]
                                                          ["PerKill"]
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,fontFamily: "Quicksand"
                                              )),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Entry Fees",
                                              style: TextStyle(
                                                color: Colors.white,fontFamily: "Quicksand"
                                              )),
                                          Text(
                                              "₹ " +
                                                  snapshot
                                                      .data[index]
                                                      .data["GameData"]
                                                          ["Entryfees"]
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,fontFamily: "Quicksand"
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ): Container(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 150),
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.orange,
                          ),
                          child: returnButton(
                              snapshot.data[index].documentID),
                        ),
                      ],
                    ),
                  );
                  }
                });
          }
        },
      ),
    );
  }


    Widget returnButton(gameid) {
    for (int i = 0; i < alreadyJoinedArray.length; i++) {
      if (alreadyJoinedArray[i] == gameid) {
        return InkWell(
          onTap: () async {},
          child: Center(
            child: Text(
              "Joined",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }
    return InkWell(
      onTap: () {
        bottomSheet(gameid);
      },
      child: Center(
        child: Text(
          "Join Contest",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void bottomSheet(gameid){
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: Colors.orange.shade500,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor:  0.5,
                      child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                              child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "DUO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,fontFamily: "Quicksand"
                      ),
                    ),
                    Text(
                      " Joining Confirmation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,fontFamily: "Quicksand"
                      ),
                    ),
                    SizedBox(height: 15),
                                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        allAccountController == true ?Text(
                          " Wallet Balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ) : Container(),
                       allAccountController == true? Text(
                          "        ₹ $showdeposit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ) : Container(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        allAccountController == true? Text(
                          "    Winning Wallet Balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ): Container(),
                        allAccountController == true? Text(
                          "₹ $showwin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ) : Container(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(child: Text("Only for PUBG Mobile",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quicksand",
                          fontSize: 15,
                        ),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "NOTE: Minimum PUBG level required 30 or above.",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,fontFamily: "Quicksand"
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "By Joining this contest you accept BattleWarriors T&c and confirm that you are a resident of India except the states of Assam, Odisha, Telangana, Nagaland or Sikkim & your age is 18 years or above",
                        style: TextStyle(
                          color: Colors.white,fontFamily: "Quicksand"
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        color: Colors.blueGrey.shade900,
                          height: MediaQuery.of(context).size.height *0.09,
                          width: MediaQuery.of(context).size.width,
                        child: OutlineButton(
                            onPressed: () async {
                              againgameId = gameid;
                              Navigator.of(context).pop();
                             setState((){
                                isLoading = true;
                              });
                              await joinContest();
                            },
                            color: Colors.blueGrey.shade800,
                            borderSide: BorderSide(color: Colors.blueGrey.shade800),
                            child: Text("CONFIRM",
                                style: TextStyle(color: Colors.white,fontFamily: "Quicksand")),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> gameData() async {
                setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('LiveGames')
        .document('$againgameId')
        .get()
        .then((dss) {
      if (dss.exists) {
        participants = dss.data["Participants"];
        remainingSeats = dss.data["GameData"]["RemainingSeats"];
        totalFees = dss.data["GameData"]["Entryfees"];
        gdate = dss.data["GameData"]["Date"];
        gtime = dss.data["GameData"]["Time"];
        gmode = dss.data["GameData"]["Mode"];
        gkill = dss.data["GameData"]["PerKill"];
        gtotal = dss.data["GameData"]["TotalSeats"];
        gtype = dss.data["GameData"]["Type"];
        gmap = dss.data["GameData"]["MapName"];
      }
    });
    print(gtotal);
    
  }

  Future<void> getDatas() async {
            setState(() {
      isLoading = true;
    });
 FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    uid = _currentUser.uid;
    await Firestore.instance
        .collection('UserJoinedGame')
        .document('$uid')
        .get()
        .then((dss) {
      if (dss.exists) {
        joinedGames = dss.data["JoinedGames"];
      }
    });
    await Firestore.instance
        .collection('UserTransactions')
        .document('$uid')
        .get()
        .then((dss) {
      if (dss.exists) {
        pubgid = dss.data["PubgId"];
        walletAmount = dss.data["DepositAmount"];
        transactions = dss.data["transactions"];
        winningWallet = dss.data["WinningAmount"];
      }
    }).then((value) async {
      await gameData();
    });

  }

  Future<void> joinContest() async {
    setState(() {
      isLoading = true;
    });
    await getDatas();
    if (totalFees == 0) {
      type = "FREE";
    } else {
      type = "PAID";
    }
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String time = new DateFormat("H:m:s").format(now);
    if (pubgid == null || pubgid == "") {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ProfileEdit();
      }));
    } else {
      // print("walletAmount $walletAmount");
      // print("totalFees $totalFees");
      if(remainingSeats != 0) {
        if (walletAmount >= totalFees) {
        deductedBalance = walletAmount - totalFees;
        Map<String, dynamic> transferData = {
          "Transfer": "OUT",
          "Date": formattedDate,
          "Time": time,
          "Amount": totalFees,
          "AccountWallet": totalFees,
          "WinningWallet": "NULL",
          "Mode": "DUO",
          "Type": type,
          "Rank": "NULL",
          "Kill": "NULL",
          "PaymentId": "",
        };
        // print("BEfore $joinedGames");
        remainingSeats = remainingSeats - 1;
        transactions.add(transferData);
        Map<String, dynamic> participation = {
          "UserId": "$uid",
          "PubgId": "$pubgid"
        };
        Map<String, dynamic> joined = {
          "GameId": "$againgameId",
        };
        participants.add(participation);
        joinedGames.add(joined);
        print("RemainingSeats $remainingSeats");
        Map<String, dynamic> gamedata = {
          "RemainingSeats": remainingSeats,
          "Date": gdate,
          "Time": gtime,
          "Entryfees": totalFees,
          "MapName": gmap,
          "Mode": gmode,
          "TotalSeats": gtotal,
          "Type": gtype,
          "PerKill": gkill,
        };
        print(gamedata);
        if (countpaidTransaction == 0 && mine == true && deductedBalance > 0) {
            countpaidTransaction = 1;
            deductedBalance = deductedBalance + 10;
              int mainbalance; List rtrans = [];
            await Firestore.instance
                .collection('UserTransactions')
                .document('$appliedCode')
                .get()
                .then((dss) {
              if (dss.exists) {
                mainbalance = dss.data['DepositAmount'];
                rtrans = dss.data['transactions'];              }
            });
            Map<String, dynamic> referalRewardAddingTransaction = {
              "Transfer": "IN",
              "Date": formattedDate,
              "Time": time,
              "Amount": 10,
              "AccountWallet": 10,
              "WinningWallet": "NULL",
              "Mode": "BALANCE",
              "Type": "NULL",
              "Rank": "NULL",
              "Kill": "NULL",
              "PaymentId": "Referal Gift",
            };
            transactions.add(referalRewardAddingTransaction);
            rtrans.add(referalRewardAddingTransaction);
            await Firestore.instance
                .document("UserTransactions/$appliedCode")
                .updateData({
              "DepositAmount": mainbalance + 10,
              "transactions": rtrans,
            }).then((value) => {print("Friend Transaction Updated")});
            await Firestore.instance
                .document("ReferalCodes/$uid")
                .updateData({
              "msg": true,
            }).then((value) => {print("Message Updated")});
          }
        await Firestore.instance.document("UserTransactions/$uid").updateData({
          "DepositAmount": deductedBalance,
          "transactions": transactions,
          'CountTrans':countpaidTransaction,
        }).then((value) => {print("Transaction Updated")});
        await Firestore.instance.document("LiveGames/$againgameId").updateData({
          "Participants": participants,
          "GameData": gamedata,
        }).then((v) {
          print("Participants Updated");
        });
        await Firestore.instance.document("UserJoinedGame/$uid").updateData({
          "JoinedGames": joinedGames,
        }).then((value) => {
              print("Joined Games Updated"),
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.blueGrey.shade800,
                content: allAccountController == true ? Text(
                  'Transaction Done Joined the Contest',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ) :Text(
                  'Contest Joined',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                duration: Duration(seconds: 4),
              ))
            });
      } 
      else if ((walletAmount + winningWallet) >= totalFees) {
        // print("Before");
        // print("winningWallet $winningWallet");
        // print("walletAmount $walletAmount");
        // print("totalFees $totalFees");
        int temp = totalFees - walletAmount;
        int tempwallet = walletAmount;
        int tempwinwallet = winningWallet;
        walletAmount = 0;
        winningWallet = winningWallet - temp;
        int finalwinwallet = tempwinwallet - winningWallet;
        remainingSeats = remainingSeats - 1;
        //         print("After");
        // print("winningWallet $winningWallet");
        // print("walletAmount $walletAmount");
        // print("totalFees $totalFees");
        Map<String, dynamic> transferData = {
          "Transfer": "OUT",
          "Date": formattedDate,
          "Time": time,
          "Amount": totalFees,
          "AccountWallet": tempwallet,
          "WinningWallet": finalwinwallet,
          "Mode": "DUO",
          "Type": type,
          "Rank": "NULL",
          "Kill": "NULL",
          "PaymentId": "",
        };
        Map<String, dynamic> gamedata = {
          "RemainingSeats": remainingSeats,
          "Date": gdate,
          "Time": gtime,
          "Entryfees": totalFees,
          "MapName": gmap,
          "Mode": gmode,
          "TotalSeats": gtotal,
          "Type": gtype,
          "PerKill": gkill,
        };
        transactions.add(transferData);
        Map<String, dynamic> participation = {
          "UserId": "$uid",
          "PubgId": "$pubgid"
        };
        Map<String, dynamic> joined = {
          "GameId": "$againgameId",
        };
        participants.add(participation);
        joinedGames.add(joined);
        // print(gamedata);
        // print(joined);
        if (countpaidTransaction == 0 && countpaidTransaction < 2 && (walletAmount + winningWallet) > 0) {
            countpaidTransaction = 1;
            walletAmount = walletAmount + 10;
              int mainbalance; List rtrans = [];
            await Firestore.instance
                .collection('UserTransactions')
                .document('$appliedCode')
                .get()
                .then((dss) {
              if (dss.exists) {
                mainbalance = dss.data['DepositAmount'];
                rtrans = dss.data['transactions'];              }
            });
            Map<String, dynamic> referalRewardAddingTransaction = {
              "Transfer": "IN",
              "Date": formattedDate,
              "Time": time,
              "Amount": 10,
              "AccountWallet": 10,
              "WinningWallet": "NULL",
              "Mode": "BALANCE",
              "Type": "NULL",
              "Rank": "NULL",
              "Kill": "NULL",
              "PaymentId": "Referal Gift",
            };
            transactions.add(referalRewardAddingTransaction);
            rtrans.add(referalRewardAddingTransaction);
            await Firestore.instance
                .document("UserTransactions/$appliedCode")
                .updateData({
              "DepositAmount": mainbalance + 10,
              "transactions": rtrans,
            }).then((value) => {print("Friend Transaction Updated")});
            await Firestore.instance
                .document("ReferalCodes/$uid")
                .updateData({
              "msg": true,
            }).then((value) => {print("Message Updated")});
          }
        await Firestore.instance.document("UserTransactions/$uid").updateData({
          "DepositAmount": walletAmount,
          "WinningAmount": winningWallet,
          "transactions": transactions,
          'CountTrans':countpaidTransaction,
        }).then((value) => print("Trasnsaction Updated"));
       await Firestore.instance.document("LiveGames/$againgameId").updateData({
          "Participants": participants,
          "GameData": gamedata,
        }).then((v) {
          print("Participants Updated");
        });
        await Firestore.instance.document("UserJoinedGame/$uid").updateData({
          "JoinedGames": joinedGames,
        }).then((value) => print("Joined Games Updated"));

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey.shade800,
          content: allAccountController == true ? Text(
                  'Transaction Done Joined the Contest',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ) :Text(
                  'Contest Joined',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
          duration: Duration(seconds: 4),
        ));
      } 
      else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey.shade800,
          content: Text(
            'Insufficient Amount! Please Add Amount in your Wallet',
            style: TextStyle(
              fontSize: 15, fontFamily: "Quicksand",
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 4),
        ));
      }
      }
      else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey.shade800,
          content: Text(
            'Seats are Full Please join another Game.',
            style: TextStyle(
              fontSize: 15, fontFamily: "Quicksand",
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 4),
        ));
      }
    }
    await alreadyJoinedGames();
    setState(() {
      isLoading = false;
    });
  }
}
