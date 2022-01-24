import 'package:dashboard/screens/screen1.dart';
import 'package:dashboard/screens/screen2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SignUp_LogIn_screen/Log_in.dart';
import 'SignUp_LogIn_screen/SignUp.dart';
import 'Welcome Screen/create_department.dart';
import 'Welcome Screen/resgister_company.dart';
import 'Welcome Screen/welcome.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
flutterToast(String mes){
  Fluttertoast.showToast(
      msg: mes,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateDepartment(),
    );
  }
}
