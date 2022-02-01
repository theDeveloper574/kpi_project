import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'allDepartment.dart';
import 'companyRegister.dart';

class VerifyCompany extends StatefulWidget {
  @override
  _VerifyCompanyState createState() => _VerifyCompanyState();
}

class _VerifyCompanyState extends State<VerifyCompany> {
  String name;
  String email;
  String password;
  String currentDate;
  List list = [];
  final uid = Uuid();
  Future getValue() async {
    await FirebaseFirestore.instance
        .collection("Company ID")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        list.add(element.id);
        print(list);
      });
    });
  }

  bool isVisible = false;
  TextEditingController _controller = TextEditingController();
  TextEditingController _depName = TextEditingController();
  final id = FirebaseAuth.instance.currentUser.uid;
  final now = DateTime.now();
  var time1 = DateTime.now();
  var time2;
  @override
  void initState() {
    getValue();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                              margin: EdgeInsets.only(top: 50),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: 'Company ID',
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              if (list.contains(_controller.text.trim())) {
                                isVisible = true;
                                print('success');
                              } else {
                                flutterToast("Please Enter Valid Code",
                                    Colors.red, Colors.white);
                                isVisible = false;
                                print('invalid id');
                              }
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: _depName,
                                decoration: InputDecoration(
                                  hintText: 'Department Name',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final pass = DateTime.now();
                                final password1 = pass.microsecondsSinceEpoch;
                                final pas = password1.toString().substring(10);
                                ///send date and time
                                ///
                                final time =DateTime.now();
                                // print(pas);
                                if (_depName.text.trim().isEmpty)
                                  flutterToast(
                                      "Department name cannot be empty",
                                      Colors.red,
                                      Colors.white);
                                else {
                                  await FirebaseFirestore.instance.
                                  collection("departments").
                                  doc(pas).set({
                                    'departments name': _depName.text,
                                    'Invitation link': uid.v4().toString().substring(24),
                                    'password': pas,
                                    'user name': name,
                                    'current user uid': id,
                                    'user email': email,
                                    'user password': password,
                                    "Date Time": DateFormat('MM dd yyy').format(now)
                                  }).then((value) {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>AllDepartment()));
                                  });
                                  setState(() {
                                    _depName.clear();
                                  });
                                }
                                // print("invitation link: " + uid.v4());
                                // print(_depName.text.trim());
                                // print("invitation link: " + uid.v4());
                                // print(DateTime.now());
                                // print("Name: " + name);
                                // print("email: " + email);
                                // print("password: " + password);
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
                                    'Create',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Visibility(
                visible: !isVisible,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Doesn't have an company? "),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyRegister()));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future getData() async {
    FirebaseFirestore.instance
        .collection('user porfile')
        .doc(id)
        .snapshots()
        .listen((event) {
      setState(() {
        name = event.get('name');
        email = event.get('email');
        password = event.get('password');
      });
    });
  }
}
