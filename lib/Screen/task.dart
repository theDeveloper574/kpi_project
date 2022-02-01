import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Widgets/taskItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'addTask.dart';

class Task extends StatefulWidget {
  String dName;
  Task({@required this.dName});
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final id = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask(dName: widget.dName)));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Tasks'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tasks').
              where('department name', isEqualTo: widget.dName).
          snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{
              return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: snapshot.data == null ? 0
                          :snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        print(widget.dName);
                        DocumentSnapshot document= snapshot.data.docs[index];
                        return TaskItem(name: document['task name'],weigth: document['task weigth'],dateTime: document['date time'],);
                      }));
            }
          },
        ));
  }
}
