import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List qoute =[
    'hello ggg ',
    'hello gggasd ',
    'hello gggasd ',
    'hello gggasd ',
    'hello gggasd ',
    'hello gggasd ',
    'hello gggasd ',
    'hello gggasd ',
  ];
  final uuid = Uuid();
  String id = '766058';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: qoute.map((e){
                return Text(e);
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Company detail")
                  .doc(id)
                  .collection('company user Info')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (ctx, int index) {
                      print('/////////////////////////');
                      return
                          Card(
                            child: Text("uniqueID"),
                          );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
