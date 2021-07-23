// import 'dart:io';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReferAndEarn extends StatefulWidget {
  @override
  _ReferAndEarnState createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  List codes = [];
  bool buttonmsg;
  bool mine;
  String mycode;
  bool isLoading = false;
  String friendCode = "";
  String friendid = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> generateReferalCode() async {
    List coder;
    setState(() {
      isLoading = true;
    });
    var uuid = Uuid();
    String s = uuid.v1();
    print(s);
    String genref = '';
    for (var i = 0; i < 6; i++) {
      if (genref.length < 6) {
        genref += s[i];
      }
    }
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('ReferalCodes')
        .document('codes')
        .get()
        .then((ds) {
      if (ds.exists) {
        coder = ds.data["ReferalCodes"];
      }
      print(coder);
      int count = 0;
      List cloneCoder = coder;
      for (var items in coder){
        if (items['id'] == authid) {
          count += 1;
        }
        
           print(cloneCoder);
           print(count);
      }
      if(count == 0){    
              Firestore.instance.document('UserTransactions/$authid').updateData({
            'CountTrans': 0,
          }).whenComplete(() => {print('NewVAlue')});
            cloneCoder.add({'id': authid, 'code': genref.toUpperCase()});
           Firestore.instance.document("ReferalCodes/codes").updateData({
             'ReferalCodes': cloneCoder,
           }).whenComplete(() => {
             print('Referal Code Updated'),
          getReferalCode(),
          getData()
           });
           Firestore.instance.document('ReferalCodes/$authid').setData({
             'appliedcode':'',
             'mine':false,
             'msg':false,
             'mycode': genref.toUpperCase(),
             'referals' : [],
          }).whenComplete(() => {print('NewVAlue')});
        }else{
          getReferalCode();
          getData();
        }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getReferalCode() async {
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('ReferalCodes')
        .document('codes')
        .get()
        .then((dss) {
      if (dss.exists) {
        codes = dss.data["ReferalCodes"];
      }
    });
    setState(() {
      isLoading = false;
    });
    getMycode(codes);
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('ReferalCodes')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        buttonmsg = dss.data['msg'];
        mine = dss.data['mine'];
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getMycode(allcodes) async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    print(allcodes);

    allcodes.forEach((items) {
      if (items['id'] == authid) {
        mycode = items['code'];
        print(mycode);
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> setReferalCode() async {
    List referals = [];
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    String myfriendid = await getFriendId(friendCode);
    print("myfriendid $myfriendid");
    if(myfriendid != null) {
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('ReferalCodes')
        .document('$myfriendid')
        .get()
        .then((dss) {
      if (dss.exists) {
        referals = dss.data['referals'];
      }
    });
    Map updatedReferals = {
      'id': authid,
    };
    referals.add(updatedReferals);
    print(referals);
    await Firestore.instance.document("ReferalCodes/$myfriendid").updateData({
      'referals': referals,
    }).then((value) => {print("Referals Updated")});

    await Firestore.instance
        .document("ReferalCodes/$authid")
        .updateData({'mine': true, 'appliedcode': friendid}).then((value) => {print("Mine Updated")});

    getData();
    setState(() {
      isLoading = false;
    });
    }
    else{
      showDialog(context: context, builder:(context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Code Not Found!!', style: TextStyle(color: Colors.white),),
        content: Text('Please Enter the valid code', style: TextStyle(color: Colors.white),),
        actions: [
          RaisedButton(onPressed: () {
            
            Navigator.of(context).pop(false);
          },
          color: Colors.blueGrey.shade900,
          child: Text('Close', style: TextStyle(color: Colors.white),),)
        ],
      ),);
    }
  }

  Future<String> getFriendId(frndcode) async {
    print(frndcode);
    int count = 0;
    codes.forEach((items) {
      if (items['code'] == frndcode) {
        // print(items['code'] + " - " + frndcode);
        count = 1;
        friendid = items['id'];
      }
    });
    // print(friendid);
    if(count == 1) {
      return friendid;
    }
    else{
      return null;
    }

  }

  @override
  void initState() {
    super.initState();
    generateReferalCode();
  }

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
            labelStyle:
                TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.add_box),
                text: "Apply Code Here",
              ),
              Tab(
                icon: Icon(Icons.people_alt),
                text: "Refer Your Friend",
              )
            ],
          ),
        ),
        body: isLoading
            ? Center(
                child: SpinKitCircle(
                  color: Colors.blueGrey.shade900,
                  size: 50.0,
                ),
              )
            : TabBarView(children: [applyCode(), referFriend()]),
      ),
    );
  }

  Widget referFriend() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/refer.jpg",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      child: Text(
                        "Invite your friend and get ₹10 each when he join the first paid match",
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(
                        "Share the code below or ask them to enter it in refer and earn section. Both will earn when he joins the paid match",
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blueGrey.shade300),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: DottedBorder(
                      color: Colors.blueGrey.shade300,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "   " + "$mycode",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blueGrey.shade300),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                          new ClipboardData(text: mycode))
                                      .then((value) => {
                                            Fluttertoast.showToast(
                                                msg: "Code Copied")
                                          });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.copy,
                                        color: Colors.blueGrey.shade300),
                                    Text(
                                      "Copy Code" + "   ",
                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.blueGrey.shade300),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blueGrey.shade800,
                      onPressed: () async {
                        const url = 'https://play.google.com/store/apps/details?id=com.warriorsbattle.battle&hl=en_IN';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
                      },
                      elevation: 10.0,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Invite Friend",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quicksand",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget applyCode() {
    return isLoading
        ? Center(
            child: SpinKitCircle(
              color: Colors.blueGrey.shade900,
              size: 50.0,
            ),
          )
        : SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/refer.jpg",
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                  ),
                  buttonmsg == false
                      ? Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Apply Code and play any paid match",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Text(
                                  "to get reward",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            child: Text(
                              "Reward Received in your wallet",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                  buttonmsg == false
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Reward will be credited in your Account Wallet",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blueGrey.shade300),
                                ),Text(
                                  "within 2 hours",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blueGrey.shade300),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: Text(
                              "You have already applied your friend code ",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blueGrey.shade300),
                            ),
                          ),
                        ),
                  mine == true
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, right: 14.0, top: 20),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60.0,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.characters,
                                onChanged: (value) async {
                                  setState(() {
                                    friendCode = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty && value.length == 6) {
                                    return 'Please Enter 8 digits referal code';
                                  }
                                  if (value == mycode) {
                                    return 'You cannot apply your own code';
                                  }
                                  return null;
                                },
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  hintText: "Referal Code",
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.add_box,
                                    color: Colors.black,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                            ),
                          ),
                        ),
                  mine == true
                      ? Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Code Applied",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.blueGrey.shade800,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await setReferalCode();
                              }
                            },
                            elevation: 10.0,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}
