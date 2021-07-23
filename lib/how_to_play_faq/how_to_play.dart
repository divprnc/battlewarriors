import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class HowToPlay extends StatefulWidget {
  @override
  _HowToPlayState createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {

  bool isLoading;
  bool allAccountController;
  
  Future<void> getaccountControl() async {
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('UserAccountControl')
        .document('Account')
        .get()
        .then((dss) {
      if (dss.exists) {
        allAccountController = dss.data["HowToPlay"];
      }
    });
        setState(() {
      isLoading = false;
    });
  }

  
  @override
  void initState(){
    super.initState();
    getaccountControl();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(
          title: Text("How To Play",style: TextStyle(fontFamily: "Quicksand",
                        ),),
        backgroundColor: Colors.blueGrey.shade900,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 120, top: 40),
                      child: Text(
                        "Joining A Contest",
                        style: TextStyle(
                            color: Colors.blueGrey.shade800,fontFamily: "Quicksand",
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                ShapeOfView(
                  child: Container(
                      color: Colors.blueGrey.shade800,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 18),
                        child: Text(
                          "1",
                          style: TextStyle(
                              color: Colors.white,fontFamily: "Quicksand",
                              fontSize: 85,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  shape: DiagonalShape(
                    angle: DiagonalAngle.deg(angle: 25),
                    position: DiagonalPosition.Right,
                    direction: DiagonalDirection.Right,
                  ),
                  width: 120,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 115,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade800,
                        border: Border.all(
                          color: Colors.orange,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1.  To Join a Contest on Battle Warriors, select the game type you want to  play\n\n 2. Select the type of contest you want to join, make sure to read the description on each contest to make sure it is right for you. \n\n 3. You will receive a room ID and a password 15 minutes before the scheduled start of the match on the app. Use this information to join on the gaming platform you had selected.\n\n 4. Make sure to read the rules of the games to flllow before the match begins. This will make sure that you have a fair play do not engage in any forgidden activity.",
                        style: TextStyle(color: Colors.white,fontFamily: "Quicksand",),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120, top: 40),
                    child: Text(
                      "After the Match",
                      style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,fontFamily: "Quicksand",),
                    ),
                  ),
                ),
                ShapeOfView(
                  child: Container(
                      color: Colors.blueGrey.shade800,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 18),
                        child: Text(
                          "2",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 85,fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  shape: DiagonalShape(
                    angle: DiagonalAngle.deg(angle: 25),
                    position: DiagonalPosition.Right,
                    direction: DiagonalDirection.Right,
                  ),
                  width: 120,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 115,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade800,
                        border: Border.all(
                          color: Colors.orange,
                        )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "After the match has concluded on the PUBG, Battle Warriors team will view from the platform to declare the final results. Based on the ranking and kills are announced to leaderboard",
                          style: TextStyle(
                            color: Colors.white,fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
           allAccountController == true ? Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120, top: 40),
                  child: Text(
                    "Wallet",
                    style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: 25,fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ShapeOfView(
                  child: Container(
                      color: Colors.blueGrey.shade800,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 18),
                        child: Text(
                          "3",
                          style: TextStyle(
                              color: Colors.white,fontFamily: "Quicksand",
                              fontSize: 85,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  shape: DiagonalShape(
                    angle: DiagonalAngle.deg(angle: 25),
                    position: DiagonalPosition.Right,
                    direction: DiagonalDirection.Right,
                  ),
                  width: 120,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 115,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade800,
                        border: Border.all(
                          color: Colors.orange,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          "You can see the deposited and winning money in your account section anytime. The details of your balance will be displayed their in the different sections. \n\n Money in the account is divided into 2 categories.\n\n Deposited:  This is the amount thay you have deposited, you can use this amount to join the contests.\n\n Winnings: This is the amount that you have won by joining any cash leagues. This amount can be withdrawn or used to play the contests. No processing fee is charged for withdrawal of this amount.\n\n\n Note: You will need to go to settings section and add the account number and IFSC code or paytm number. This is to make sure that your money goes in the right hands and is under the guidelines of the Indian laws.",
                          style: TextStyle(color: Colors.white,fontFamily: "Quicksand",),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
