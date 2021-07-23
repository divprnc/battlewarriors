import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List notifications = [];
  bool isLoading = false;
   Future<void> getnotificationsCount() async{
     setState(() {
       isLoading = true;
     });
                await Firestore.instance
          .collection('Notifications')
          .document('noti')
          .get()
          .then((dss) {
            if(dss.exists) {
              notifications = dss.data["notify"].reversed.toList(); 
             
            }
      });
      setState(() {
        isLoading = false;
      });
      
  }
  @override
  void initState() {
    super.initState();
    getnotificationsCount();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications",style: TextStyle( fontFamily: "Quicksand",),),
        backgroundColor: Colors.blueGrey.shade900,
        ),
        body:  isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    border:Border.all(
                      color: Colors.orange,
                       width: 1.1
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      notifications[index],
                      style: TextStyle(
                        color: Colors.white, fontFamily: "Quicksand",
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}