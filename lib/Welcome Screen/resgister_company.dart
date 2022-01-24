
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Welcome%20Screen/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterCompany extends StatefulWidget {
  @override
  _RegisterCompanyState createState() => _RegisterCompanyState();
}
class _RegisterCompanyState extends State<RegisterCompany> {
  TextEditingController _companyName = TextEditingController();
  TextEditingController _companyPhone = TextEditingController();
  TextEditingController _companyAddress = TextEditingController();
  TextEditingController _companyEmail = TextEditingController();
  final db = FirebaseFirestore.instance;
  bool visibility = true;
  String errorMessage  ='';
  bool isLoading = false;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Center(
                      child: Text(
                        "Register Company",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 29,
                            fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _companyName,
                      validator: validateCompanyName,
                      decoration: InputDecoration(
                          hintText: 'Company Name',
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
                    child: InternationalPhoneNumberInput(
                        textFieldController: _companyPhone,
                        hintText: 'Enter Phone Number',

                        inputDecoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width: 1.4)),
                        ),
                        selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG
                        ),
                        onInputChanged: (value){}),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(
                      controller: _companyAddress,
                      validator: validateCompanyAddress,
                      decoration: InputDecoration(
                          hintText: 'Company Address',
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
                      controller: _companyEmail,
                      validator: validateCompanyEmail,
                      decoration: InputDecoration(
                          hintText: 'Comapny Email',
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
                  Center(child: Text(errorMessage, style: TextStyle(
                      color: Colors.red
                  ),)),
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
                      child:  isLoading ? CircularProgressIndicator(color: Colors.white,) :Text("Register", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 19
                      ),),
                      onPressed: ()async{
                        var random = DateTime.now();
                        var ID  = random.microsecondsSinceEpoch.toString();
                        var sunID = ID.substring(10);
                        print(sunID);
                          if(_key.currentState.validate()){
                            try{
                              errorMessage ='';
                              await FirebaseFirestore.instance.collection("Company detail").
                              doc(sunID).collection("company user Info").doc(DateTime.now().toString()).set({
                                "Company Name": _companyName.text.trim(),
                                "Company Phone": _companyPhone.text.trim(),
                                'Company Address': _companyAddress.text.trim(),
                                'Company Email':_companyEmail.text.trim(),
                                'uniqueID': sunID,
                                'time': DateTime.now().toString(),
                              }).then((value) {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Welcome()));
                              });
                            }on FirebaseException catch(error){
                              errorMessage = error.message;
                            }
                          }
                        //   setState(() => isLoading = false);
                        // }
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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

String validateCompanyName(String formName){
  if(formName == null || formName.isEmpty)
    return 'Company Name is required';
  // if(formName.length < 6)
  //   return "Name length cannot be less than 6";
  // return null;
}
String validateCompanyAddress(String formName){
  if(formName == null || formName.isEmpty)
    return 'Company Address is required';
  // if(formName.length < 6)
  //   return "Name length cannot be less than 6";
  // return null;
}
String validateCompanyEmail(String email){
  if(email == null || email.isEmpty)
  return 'Email address is required';
  String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(email)) return 'Invalid E-mail Address format.';
  return null;
}