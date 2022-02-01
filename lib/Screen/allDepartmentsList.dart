


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllDepartmentsList extends StatefulWidget {

  @override
  _AllDepartmentsListState createState() => _AllDepartmentsListState();
}

class _AllDepartmentsListState extends State<AllDepartmentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All departments List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('departments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            return ListView.builder(
              itemCount:  snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index){
                DocumentSnapshot document =snapshot.data.docs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: InkWell(
                    onTap: (){
                     print('////////');
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
              },
            );
          }
        },),
    );
  }
}
