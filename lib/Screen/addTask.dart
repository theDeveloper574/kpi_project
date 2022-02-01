import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  String dName;
  AddTask({@required this.dName});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _taskName = TextEditingController();
  TextEditingController _taskWeight = TextEditingController();
  final id = FirebaseAuth.instance.currentUser.uid;
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _taskName,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Task Name')),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _taskWeight,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Task Weight')),
            ),
            GestureDetector(
              onTap: () async{
                if(_taskName.text.trim() == null ||_taskName.text.trim().isEmpty ||
                    _taskWeight.text.trim() == null ||_taskWeight.text.trim().isEmpty){
                  flutterToast('Please fill all Fields', Colors.red, Colors.white);
                }else{
                  await FirebaseFirestore.instance.
                  collection('tasks').
                  doc().set({
                    'department name': widget.dName,
                    'task name': _taskName.text,
                    'task weigth': _taskWeight.text,
                    'current user is': id,
                    'date time': DateFormat('MM dd yyy').format(now)
                  }).then((value) {
                    Navigator.pop(context);
                  });
                }
                setState(() {
                  _taskName.clear();
                  _taskWeight.clear();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Add',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
