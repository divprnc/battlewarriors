import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:expandable/expandable.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
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
        allAccountController = dss.data["Faq"];
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getaccountControl();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "FAQ",
            style: TextStyle(
              fontFamily: "Quicksand",
            ),
          ),
          backgroundColor: Colors.blueGrey.shade900),
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Can we play pubg lite contests in Battle Warriors ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "No! the Battle Warriors application is only valid for only PUBG Mobile.            ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "How to contact us??",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "You can contact us from our email gamershubcontest@gmail.com for any queries            ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "How i can update my mobile number ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "You can see your mobile number in profile section, profile edit section and settings section. You can only update your mobile number in settings section. We recommend your to enter the mobile number as your paytm number if you want to withdraw the money in the paytm wallet. You can update your mobile number at a time only if you want to change your mobile number then please go to contact us section and send a mail with subject MOBILE NUMBER UPDATE (In capital letters) and please email us from your registred email else we will not be able to update the mobile number.            ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "How i can withdraw the winning wallet balance? ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "You can see the deposited and winning money in your account section anytime. The details of your balance will be displayed their in the different sections.\nMoney in the account is divided into 2 categories.\nDeposited:  This is the amount thay you have deposited, you can use this amount to join the contests.\n Winnings: This is the amount that you have won by joining any cash leagues. This amount can be withdrawn through the paytm wallet or account number or used to play the contests.\nNo processing fee is charged for withdrawal of this amount.\n Note: You will need to go to settings section and add the account number and IFSC code or paytm number to your profile.  This is to make sure that your money goes in the right hands and is under the guidelines of the Indian laws.             ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "What is the minimum amount of i can withdraw?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "Minimum amount you can withdraw  to your bank account or paytm number is 30 Rupees. Make sure you have added your account number or paytm number in order to withdraw the amount.            ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Why i am not able to update pubg username in profile ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "You can found Pubg Username in your pubg game, you have to enter that pubg username in the profile section Please be sure because you cannot change it again. If you want to change the Pubg username please go to contact section and send a mail with subject PUBG USERNAME UPDATE (In capital letters) and please email us from your registered email else we will not be able to update the your pubg username.            ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "When i will get the room id and password ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "When you join any contest free or paid you can see your joined contests and completed contests in the My Contest section. In Joined Contest section you will get the Room ID and Room Password 15 minutes before the match timing. You have to come to the My Contest section before 15 minutes and login login it to the room. Please don't share the room ID and password to other person your account will be dissabled and you will not get any reward from your winnings.             ",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "How much time will take to announce the result ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "You will get the match result and of your kill and rank in Completed contests within 5- 10 hours after the match is completed.",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "What if i miss the joined the contest ?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "If you have missed the the no amount will be refunded so you have to be on time to join the contest.            ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "I am not able to add the money with wallets ?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "If you want to add the amount go to account section and click on add amount to add the amount to your account wallet. If you will select the wallet option in the payments no amount will be add to your wallet, so please user other payment methods to add the payment to your wallet.            ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Why i am not able to join the contest ?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "There are 2 reasons you will not be able to join the contest. \n1. If you have not added your PUBG username to your profile (if you have not added your PUBG username to your profile and try to join the contest you will automatically redirect to profile section to add the PUBG Username)\n2. If there is less amount or no amount in your account wallet or winning wallet.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  allAccountController == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: ExpandablePanel(
                              hasIcon: true,
                              tapHeaderToExpand: true,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.top,
                              tapBodyToCollapse: true,
                              header: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "If i join the contest from which wallet balance will be deducted ?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Quicksand",
                                        fontSize: 15),
                                  )),
                              expanded: Text(
                                "1. If there is no amount in your wallet you will only able to join the free contests.\n2. To join the paid contests you have to add the money in your account wallet.\n3. Your account wallet money is equal or more than the entry fees of the match.\n4. The money will be deducted from the winning wallet when you have insufficient balance in your account wallet.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Why i am not able to see the history of my matches?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: allAccountController == true
                            ? Text(
                                "We will only save your match and transcation details for 15 days only. After 15 days the details of your contests and transaction will be deleted.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )
                            : Text(
                                "We will only save your match details for 15 days only. After 15 days the details of your contests will be deleted.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Quicksand",
                                    fontSize: 12),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: ExpandablePanel(
                        hasIcon: true,
                        tapHeaderToExpand: true,
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                        header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "How to change the password ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 15),
                            )),
                        expanded: Text(
                          "You can change the password of your email in settings section or by clciking on the forget password option on the login page.",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Quicksand",
                              fontSize: 12),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
