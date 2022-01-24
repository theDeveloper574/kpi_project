import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Welcome%20Screen/welcome.dart';
import 'package:dashboard/screens/screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignUp.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool visibility = true;
  String errorMessage  ='';
  bool isLoading = false;
  final  auth = FirebaseAuth.instance.currentUser;


  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 29,
                            fontWeight: FontWeight.w700),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'asset/logo.png',
                          )
                      ),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _email,
                      validator: validateEmail,
                      decoration: InputDecoration(
                          hintText: 'Email address',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.8))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _password,
                      validator: validatePassword,
                      obscureText: visibility,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                visibility =!visibility;
                              });
                            },
                            icon: Icon(
                                visibility ? Icons.visibility_off : Icons.visibility
                            ),
                          ),
                          hintText: 'Password',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                          hintStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.8))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(child: Text(errorMessage, style: TextStyle(
                        color: Colors.red
                    ),)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: MaterialButton(
                      child:  isLoading ? CircularProgressIndicator(color: Colors.white,) :Text("Log In", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 19
                      ),),
                      onPressed: ()async{
                        setState(() => isLoading = true);
                        if(_key.currentState.validate()){
                          try{
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text).then((value){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Welcome()));
                            });
                          }on FirebaseException catch(error){
                            errorMessage = error.message;
                          }
                          setState(() => isLoading = false);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>SignUp()));
                              },
                              child: Text(
                                "sign up".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
String validateEmail(String formEmail){
  if(formEmail == null || formEmail.isEmpty)
    return 'Email address is required';
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}
String validatePassword(String formPassword){
  if(formPassword == null || formPassword.isEmpty)
    return 'Password is required';
  if(formPassword.length < 6)
    return 'Password is to weak';
  return null;
}
