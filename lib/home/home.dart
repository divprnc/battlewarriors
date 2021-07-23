import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gamershub/Screens/faq.dart';
import 'package:gamershub/Screens/home_body.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gamershub/Screens/how_to_play.dart';
import 'package:gamershub/Screens/leaderboard.dart';
import 'package:gamershub/Screens/login.dart';
import 'package:gamershub/Screens/mycontest.dart';
import 'package:gamershub/Screens/notifications.dart';
import 'package:gamershub/Screens/privacy_policy.dart';
import 'package:gamershub/Screens/profile.dart';
import 'package:gamershub/Screens/refer_and_earn.dart';
import 'package:gamershub/Screens/settings.dart';
import 'package:gamershub/Screens/terms_condition.dart';
import 'package:gamershub/Screens/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String noticount;
  List notifications;
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool allAccountController;
  bool referAndEarnController;
  bool personalAccountController;
  bool updatingBlocker;
  int _selectedIndex = 0;
  final List<Widget> _wid = [
    HomeBody(),
    MyContest(),
    LeaderBoardPage(),
  ];
  void _onClickChange(int index) {
    setState(() {
      _selectedIndex = index;
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
        referAndEarnController = dss.data["Refer"];
        updatingBlocker = dss.data["UpdatingBlocker"];
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
    print(allAccountController);
    print(personalAccountController);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getnotificationsCount() async {
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('Notifications')
        .document('noti')
        .get()
        .then((dss) {
      if (dss.exists) {
        notifications = dss.data["notify"];
      }
    });
    noticount = notifications.length.toString();
    if (noticount == "null" || noticount == null || noticount == "") {
      noticount = "";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getaccountControl();
    getnotificationsCount();
  }

  Widget drawerMenu(String title, IconData icon, Function func) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.orange.shade500,
          fontSize: 18,
          fontFamily: "Quicksand",
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      onTap: func,
    );
  }

  Future<bool> _backButtonPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blueGrey.shade900,
              title: Text(
                "Do you Really Want to Exit ?",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ));
  }

  Future<void> sendEmail() async {
    setState(() {
      isLoading = true;
    });
    final Email email = Email(
      recipients: ['gamershubcontest@gmail.com'],
    );
    await FlutterEmailSender.send(email).then((value) => print("Email Sended"));
    setState(() {
      isLoading = false;
    });
  }

  Widget inReviewWidget() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg3.jpg"), fit: BoxFit.cover)),
      child: AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          "Currently app is in development process. Please Update the app after sometime",
          style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          RaisedButton(
            onPressed: () async {
              const url = 'https://play.google.com/store/apps/details?id=com.warriorsbattle.battle&hl=en_IN';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            color: Colors.blueGrey.shade900,
            child: Text("Update",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _backButtonPressed,
        child: updatingBlocker == true
            ? inReviewWidget()
            : Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return NotificationsPage();
                        }));
                      },
                      child: Stack(
                        children: <Widget>[
                          new Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          new Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Center(
                                child: new Text(
                                  noticount.toString(),
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                  title: Text(
                    "Battle Warriors",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                    ),
                  ),
                  backgroundColor: Colors.blueGrey.shade900,
                ),
                drawer: Drawer(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade900),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                color: Colors.orange,
                                height: 180,
                                width: double.infinity,
                              ),
                              Positioned(
                                  left: 90,
                                  top: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/avatar.jpg"),
                                    maxRadius: 50,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          drawerMenu("Profile", Icons.perm_identity, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ProfilePage();
                            }));
                          }),
                          allAccountController == true &&
                                  personalAccountController == true
                              ? drawerMenu(
                                  "Account", Icons.account_balance_wallet, () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return WalletPage();
                                  }));
                                })
                              : Container(),
                          drawerMenu("Contact Us", Icons.help_outline, () {
                            sendEmail();
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            //   return ContactUsPage();
                            // }));
                          }),
                          referAndEarnController == true ? drawerMenu("Refer and Earn", Icons.people, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ReferAndEarn();
                            }));
                          }) : Container(),
                          drawerMenu("Terms And Condition", Icons.new_releases,
                              () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return TermsAndCondition();
                            }));
                          }),
                          drawerMenu("Privacy Policy", Icons.announcement, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return PrivacyPolicy();
                            }));
                          }),
                          drawerMenu("How To Play", Icons.pages, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return HowToPlay();
                            }));
                          }),
                          drawerMenu("FAQ", Icons.flare, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FaqPage();
                            }));
                          }),
                          drawerMenu("Settings", Icons.settings, () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return SettingsPage();
                            }));
                          }),
                          drawerMenu("Log Out", Icons.subdirectory_arrow_left,
                              () {
                            _signOut();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                body: isLoading
                    ? Center(
                        child: SpinKitCircle(
                          color: Colors.blueGrey.shade900,
                          size: 50.0,
                        ),
                      )
                    : _wid[_selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.blueGrey.shade900,
                  type: BottomNavigationBarType.shifting,
                  selectedItemColor: Colors.orange,
                  currentIndex: _selectedIndex,
                  onTap: _onClickChange,
                  items: [
                    BottomNavigationBarItem(
                        backgroundColor: Colors.blueGrey.shade900,
                        icon: Icon(
                          Icons.home,
                        ),
                        label: "Home"
                        ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.blueGrey.shade900,
                      icon: Icon(
                        Icons.star_border,
                      ),
                      label: 'My Contest',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.blueGrey.shade900,
                      icon: Icon(
                        Icons.assistant_photo,
                      ),
                      label: 'LeaderBoard',
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _signOut() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser user = await _auth.currentUser();
    bool result = await facebookSignIn.isLoggedIn;
    if (user != null && user.isEmailVerified == true) {
      print("Email");
      await FirebaseAuth.instance.signOut().then((_) {
        print("Sign Out");
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", ModalRoute.withName("/home"));
      });
    } else if (result == true) {
      print("Facebook");
      await facebookSignIn.logOut();
      print('Logged out.');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LoginPage();
      }));
    } else {
      print("Not Logged In");
    }
    setState(() {
      isLoading = false;
    });
  }
}
