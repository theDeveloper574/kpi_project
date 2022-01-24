
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FillPage extends StatefulWidget {
  @override
  _FillPageState createState() => _FillPageState();
}

class _FillPageState extends State<FillPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Center(child: Text("welcome", style: TextStyle(
                fontSize: 27
              ),))
            ],
          ),
        ),
      ),
    );
  }
}
