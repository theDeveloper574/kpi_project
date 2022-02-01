import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';

import 'allDepartment.dart';

class JoinDepartment extends StatefulWidget {
  @override
  _JoinDepartmentState createState() => _JoinDepartmentState();
}
class _JoinDepartmentState extends State<JoinDepartment> {
  TextEditingController _invitationCode = TextEditingController();
  TextEditingController _password = TextEditingController();
  String name;
  List inviteCode =[];
  List password =[];
  Future getData()async{
    await FirebaseFirestore.instance.
    collection("departments").get().
    then((value) {
      value.docs.forEach((element) {
        // print(element.id);
        inviteCode.add(element['Invitation link']);
        password.add(element['password']);
        print(inviteCode);
        print(password);
      });
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _invitationCode,
                decoration: InputDecoration(
                  hintText: 'Invitation Code',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(inviteCode.contains(_invitationCode.text.trim()) &&
                    password.contains(_password.text.trim())){
                  print("work");
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>AllDepartment()));
                }
                else{
                  flutterToast('invalid invitation link or password', Colors.red, Colors.white);
                  print('//////////////////////////////');
                }
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: 15, top: 30),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Join',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
