import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Screen/slider.dart';
import 'package:dashboard/Screen/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllDepartment extends StatefulWidget {
  @override
  _AllDepartmentState createState() => _AllDepartmentState();
}

class _AllDepartmentState extends State<AllDepartment> {
  ///
  /// side menu or slider key
  ///
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final id = FirebaseAuth.instance.currentUser.uid;
  final now = DateTime.now();
  // final uid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,

          ///
         /// side menu
        ///
      drawer: DrawerSlider(),
      appBar: AppBar(
        title: Text('Departments'),
        leading: InkWell(
            onTap: () {
              ///
              /// when user click on menu icon side menu or slider is opened
              ///
              _scaffold.currentState.openDrawer();
            },
            child: Icon(Icons.menu)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('departments').
        where('current user uid',isEqualTo: id).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
                itemCount:  snapshot.data.docs.length,
                itemBuilder: (ctx, int index){
                  DocumentSnapshot document = snapshot.data.docs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: InkWell(
                      onTap: (){
                        // print(index);
                        // print(document['departments name']);
                        Navigator.
                        push(context,
                            MaterialPageRoute(builder: (context)=>Task(dName: document['departments name'],)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(document['departments name']),
                                Text(document['Date Time'],style: TextStyle(
                                  fontWeight: FontWeight.w700
                                ),)
                              ],
                            ),
                      ),
                    ),
                  );
                });
          }
        },)
    );
  }
}
