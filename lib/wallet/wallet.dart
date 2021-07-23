import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/payment_status.dart';
import 'package:gamershub/Screens/withdraw_amount.dart';
import 'add_amount.dart';
class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {  
  bool isLoading = false;
  bool check;
  List transactions = [];
  int depositedAmount;
  int winningWallet;
  Future<void> fetchUserAmountDatas() async {
    setState(() {
      isLoading = true;
    });
          FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
            await Firestore.instance
          .collection('UserTransactions')
          .document('$authid')
          .get()
          .then((dss) {
            if(dss.exists) {
              depositedAmount = dss.data["DepositAmount"]; 
              transactions = dss.data["transactions"].reversed.toList();
              winningWallet = dss.data["WinningAmount"];
            }
      });
      // transactions.reversed.toList();
      // print(transactions);
      setState(() {
        isLoading = false;
      });
  }
    Future<void> checker() async { 
         setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('PaymentProcessing')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        check = dss.data["Check"];
      }
    });
    print(check);
      setState(() {
        isLoading = false;
      });
  }
    @override
  void initState() {
    super.initState();
    fetchUserAmountDatas();
    checker();
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
            labelStyle: TextStyle(
              fontFamily: "Quicksand", 
              fontWeight: FontWeight.bold
            ),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                text: "Account Wallet",
              ),
              Tab(
                icon: Icon(Icons.attach_money),
                text: "Winning Wallet",
              )
            ],
          ),
        ),
        body: TabBarView(children: [walletContainer(), winContainer()]),
      ),
    );
  }

  Widget walletContainer() {
    return  isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(color: Colors.blueGrey.shade900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Text(
                  "Deposited Amount",
                  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: "Quicksand", ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: Text(
                  "₹ " + depositedAmount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Quicksand", ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 60, left: 240),
                  child: OutlineButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return AddAmountPage();
                      }));
                    },
                    color: Colors.orange,
                    highlightColor: Colors.orange,
                    borderSide: BorderSide(color: Colors.orange),
                    child: Text("Add Amount", style: TextStyle(color: Colors.white,fontFamily: "Quicksand", )),
                    ),
                ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Recent Transactions",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,fontFamily: "Quicksand", 
                fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_,  index) {
                  return  transactions[index]["Transfer"] == "IN" && 
                          transactions[index]["Mode"] == "BALANCE" &&
                          transactions[index]["Type"] == "NULL"  ? 
                  Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                        
                          isThreeLine: true,
                          leading: Icon(Icons.add, color: Colors.green),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"] +"\n" + "Payment Id     " + transactions[index]["PaymentId"], style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Amount Added", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.green),),
                        )
                        ),
                    ) :  transactions[index]["Transfer"] == "OUT" && 
                          transactions[index]["Mode"] != "BALANCE" &&
                          transactions[index]["Type"] != "NULL" &&  
                          transactions[index]["WinningWallet"] == "NULL" ? Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.remove, color: Colors.red,),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"]+ "\nGametype  " + transactions[index]["Mode"] + "\nDeducted from Account Wallet  ₹ " + transactions[index]["AccountWallet"].toString() + "\nDeducted from Winning Wallet  ₹ " + (transactions[index]["WinningWallet"].toString() == "NULL" ? "0" : transactions[index]["WinningWallet"].toString()), style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Joined Game", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.red),),
                        )
                        ),
                    ) : 
                                              transactions[index]["Transfer"] == "OUT" && 
                                              transactions[index]["Mode"] != "BALANCE" &&
                                              transactions[index]["Type"] != "NULL" &&  
                                              transactions[index]["WinningWallet"] != "NULL" &&  
                                              transactions[index]["AccountWallet"] != "NULL" ? Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.remove, color: Colors.red,),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"]+ "\nGametype " + transactions[index]["Mode"] + "\nDeducted from Account Wallet  ₹ " + transactions[index]["AccountWallet"].toString() + "\nDeducted from Winning Wallet  ₹ " + (transactions[index]["WinningWallet"].toString() == "NULL" ? "0" : transactions[index]["WinningWallet"].toString()), style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Joined Game", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.red),),
                        )
                        ),
                    ) : Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget winContainer() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(color: Colors.blueGrey.shade900),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Text(
                  "Winning Amount",
                  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: "Quicksand", ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: Text(
                  "₹ " + winningWallet.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Quicksand", ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.6,
                child: OutlineButton(onPressed: () {
                  if(check == true) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return PaymentStatus();
                  }));
                  }else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return WithdrawAmount();
                  }));
                  }
                  
                },
                color: Colors.orange,
                highlightColor: Colors.orange,
                borderSide: BorderSide(color: Colors.orange),
                child: Text("Withdraw", style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Quicksand", )),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.16,
                left: MediaQuery.of(context).size.width * 0.47,
                child: Text(
                  "Minimum Amount should be ₹ 30 ",
                  style: TextStyle(color: Colors.orange, fontSize: 12,fontFamily: "Quicksand", ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Recent Transactions",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,fontFamily: "Quicksand", 
                fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_,  index) {
                  return  transactions[index]["Transfer"] == "IN"   &&
                  transactions[index]["Mode"] != "BALANCE"  && 
                  transactions[index]["Type"] != "NULL" ? Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.add, color: Colors.green),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"] +"\n" + "Mode     " + transactions[index]["Mode"] + " \n" + "Rank  " + transactions[index]["Rank"].toString() + "\nKill  " + transactions[index]["Kill"].toString(), style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Amount Added", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.green),),
                        )
                        ),
                    ) :   
                                        transactions[index]["Transfer"] == "OUT"   &&
                                        transactions[index]["Mode"] == "BALANCE"  && 
                                        transactions[index]["Type"] == "NULL" ? Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.remove, color: Colors.red,),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"]+  "\n Payment Id    " + transactions[index]["PaymentId"]+  "\n Payment Status    " + transactions[index]["Status"], style: TextStyle(fontFamily: "Quicksand", )),
                          title: Text("Balance Withdrawn", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.red),),
                        )
                        ),
                    ) :  
                                                                transactions[index]["Transfer"] == "OUT" && 
                                                                transactions[index]["Mode"] != "BALANCE" &&
                                                                transactions[index]["Type"] != "NULL" &&  
                                                                transactions[index]["WinningWallet"] != "NULL" &&  
                                                                transactions[index]["AccountWallet"] != "NULL"    ? Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.remove, color: Colors.red,),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"]+ "\nGametype " + transactions[index]["Mode"] + "\nDeducted from Account Wallet  ₹ " + transactions[index]["AccountWallet"].toString() + "\nDeducted from Winning Wallet  ₹ " + (transactions[index]["WinningWallet"].toString() == "NULL" ? "0" : transactions[index]["WinningWallet"].toString()), style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Joined Game", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.red),),
                        )
                        ),
                    ) :
                                                                transactions[index]["Transfer"] == "OUT" && 
                                                                transactions[index]["Mode"] != "BALANCE" &&
                                                                transactions[index]["Type"] != "NULL" &&  
                                                                transactions[index]["WinningWallet"] != "NULL"  ?    Card(
                      elevation: 5,
                      child: Container(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Icon(Icons.remove, color: Colors.red,),
                          subtitle: Text(transactions[index]["Date"] + "    " + transactions[index]["Time"]+ "\nGametype " + transactions[index]["Mode"] + "\nDeducted from Account Wallet  ₹ " + transactions[index]["AccountWallet"].toString() + "\nDeducted from Winning Wallet  ₹ " + (transactions[index]["WinningWallet"].toString() == "NULL" ? "0" : transactions[index]["WinningWallet"].toString()), style: TextStyle(fontFamily: "Quicksand", ),),
                          title: Text("Joined Game", style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold),),
                          trailing: Text("₹ " + transactions[index]["Amount"].toString(), style: TextStyle(fontSize: 20,fontFamily: "Quicksand",  fontWeight: FontWeight.bold,color: Colors.red),),
                        )
                        ),
                    ): Container();},
              ),
            ),
          ),
        ],
      ),
    );
  }

}
