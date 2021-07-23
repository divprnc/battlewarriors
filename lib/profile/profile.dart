import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  String name;
  String email;
  String pubgid;
  String mobile;
  String upi;
  String state;
  Future<void> getUserData() async {
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('UserData')
        .document('$authid')
        .get()
        .then((ds) => {
          name = ds.data['FullName'],
          email = ds.data['Email'],
          pubgid = ds.data['PubgId'],
          mobile = ds.data['MobileNum'],
          upi = ds.data['UpiId'],
          state = ds.data['State'],

        });
        setState(() {
      isLoading = false;
    });
  }
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
        allAccountController = dss.data["Profile"];
      }
    });
        setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getaccountControl();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right:20
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ProfileEdit()));
              },
              child: Icon(
                Icons.edit,
                size: 26.0,
              ),
            ),
          )
        ],
        title: Text("Profile",style: TextStyle( fontFamily: "Quicksand",),),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      backgroundColor: Colors.white60,
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: ClippingClass(),
                    child: Container(
                      height: 250,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Divider(
                                color: Colors.black38,
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.all_inclusive),
                                title: Text(
                                  "PUBG Username",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Quicksand",),
                                ),
                                subtitle: Text(pubgid.toString(), style: TextStyle( fontFamily: "Quicksand",),),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.blueGrey.shade800,
                                      content: Text(
                                        'This is the username thay you use on Pubg. Once this is entered it cannot be changed',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white, fontFamily: "Quicksand",
                                        ),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ));
                                  },
                                  child: Icon(Icons.info),
                                ),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(
                                  "Mobile Number",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Quicksand",),
                                ),
                                subtitle: Text("+91-" + mobile.toString(), style: TextStyle( fontFamily: "Quicksand",),),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.blueGrey.shade800,
                                      content: allAccountController == true ? Text(
                                        'This is your mobile number, you can change it from settings. Make sure it is your paytm number to receive your payments',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white, fontFamily: "Quicksand",
                                        ),
                                      ):Text(
                                        'This is your mobile number, you can change it from settings. ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white, fontFamily: "Quicksand",
                                        ),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ));
                                  },
                                  child: Icon(Icons.info),
                                ),
                              ),
                            ),
                            // Card(
                            //   child: ListTile(
                            //     leading: Icon(Icons.system_update),
                            //     title: Text(
                            //       "Upi Id",
                            //       style: TextStyle(fontWeight: FontWeight.bold),
                            //     ),
                            //     subtitle: Text(upi.toString()),
                            //   ),
                            // ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.location_city),
                                title: Text(
                                  "State",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Quicksand",),
                                ),
                                subtitle: Text(state.toString(), style: TextStyle( fontFamily: "Quicksand",),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 130, top: 125),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.orange, width: 2.4),
                          borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                        maxRadius: 50,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 225
                      ),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, fontFamily: "Quicksand",
                                  fontSize: 25),
                            ),
                      Text(
                        email.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45, fontFamily: "Quicksand",
                            fontSize: 20),
                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
