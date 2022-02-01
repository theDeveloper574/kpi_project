import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Screen/task.dart';
import 'package:flutter/material.dart';

class DepartmentItem extends StatefulWidget {
  @override
  _DepartmentItemState createState() => _DepartmentItemState();
}

class _DepartmentItemState extends State<DepartmentItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('departments').snapshots(),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Task(dName: null)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(document['departments name']),
                    ],
                  ),
                ),
              ),
            );
          });
        }
      },);
  }
}
