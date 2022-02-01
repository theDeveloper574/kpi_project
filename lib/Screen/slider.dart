import 'package:dashboard/Screen/allDepartmentsList.dart';
import 'package:dashboard/Screen/report.dart';
import 'package:flutter/material.dart';

class DrawerSlider extends StatefulWidget {
  @override
  _DrawerSliderState createState() => _DrawerSliderState();
}

class _DrawerSliderState extends State<DrawerSlider> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              height: 250,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print("success");
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>AllDepartmentsList()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        'All Department',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Report()));
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text('Report')),
                  ),
                  Container(child: Text('Change Password')),
                  Container(child: Text('Setting')),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Logout'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
