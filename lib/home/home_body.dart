import 'package:flutter/material.dart';
import 'package:gamershub/Screens/duo.dart';
import 'package:gamershub/Screens/solo.dart';
import 'package:gamershub/Screens/squad.dart';
import 'package:gamershub/Screens/tdm.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Widget topDesign() {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              )),
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 35, top: 50),
          child: Text(
            "Welcome",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                fontSize: 45),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 90, top: 93),
          child: Text(
            "To the Battle Warriors",
            style: TextStyle(
                color: Colors.white, fontFamily: "Quicksand", fontSize: 15),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 162, left: 37),
          child: Text(
            "Run Loot Die Repeat...",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget events(String image, String name) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Colors.blueGrey.shade900,
                border: Border.all(color: Colors.blueGrey.shade800, width: 3),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
                  image: AssetImage(
                    image,

                  ),
                  
                  fit: BoxFit.cover,
                  
                ),
                ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.16,
                  left: MediaQuery.of(context).size.width * 0.46,
                                  child: Container(
                    height: 70,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        border: Border.all(
                          color: Colors.orange,
                        ),
                        color: Colors.white.withOpacity(0.1)),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 45,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.82,
                      child: Opacity(
              opacity: 0.3,
              child: Image(
                image: AssetImage(
                  'assets/images/playstore.png',
                ),
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          topDesign(),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: events("assets/images/solo.jpg", "SOLO"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SoloPage();
              }));

              // Navigator
            },
          ),
          GestureDetector(
            child: events("assets/images/duo.jpg", "DUO"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return DuoPage();
              }));
            },
          ),
          GestureDetector(
            child: events("assets/images/squads.jpg", "SQUAD"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SquadPage();
              }));
            },
          ),
          GestureDetector(
            child: events("assets/images/tdm.jpg", "TDM"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return TdmPage();
              }));
            },
          )
        ],
      ),
    );
  }
}
