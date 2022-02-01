import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class screen extends StatefulWidget {
  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  // String name;
  // final id = FirebaseAuth.instance.currentUser.uid;
  final now = DateTime.now();
  var time = DateTime.now();
  var senTime;
  var senTime1;
  getdate()async{
    Future.delayed(Duration(seconds: 2)).then((value) {
     senTime =  time.microsecondsSinceEpoch;
     senTime1= senTime.toString().substring(12);
    });
  }
  @override
  void initState() {
    getdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              print(senTime1);
              // Future.delayed(Duration(seconds: 2)).then((value) {
              //   final time = DateTime.now();
              //   final time1 = time.microsecondsSinceEpoch;
              //   final res = time1.toString().substring(12);
              //   print(res);
              // });
            },
              child: Center(child: Text(DateFormat('dd MM yyy').format(now)))),
        ],
      )
    );
  }
    // var userName;
    // Future<void> getPhoto() async {
    //   //query the user all data
    //   await FirebaseFirestore.instance.collection("user porfile")
    //       .doc(id)
    //       .snapshots()
    //       .listen((event) {
    //     setState(() {
    //       userName = event.get('name');
    //       print(userName);
    //     });
    //   });
    // }
}