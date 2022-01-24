import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/main.dart';
import 'package:dashboard/screens/screen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'Log_in.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  final db = FirebaseFirestore.instance;
  bool visibility = true;
  String errorMessage  ='';
  bool isLoading = false;
  final  auth = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  PickedFile imageFile;
  String imageUrl;
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: CircleAvatar(
                            radius: 70,
                            child: imageFile == null ? Text(
                              'No Image', style: TextStyle(fontSize: 20),) :
                            ClipOval(
                                child: Image.file(File(imageFile.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .width,)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 170,
                        bottom: 0,
                        child: IconButton(icon: Icon(Icons. camera_alt_rounded,size: 24,),onPressed:()async{
                        final picked = await ImagePicker().getImage(
                            source: ImageSource.gallery);
                        setState(() {
                          imageFile = picked;
                        });
                      }),)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                      child: Text(
                        "Sign Up",
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
                      controller: _firstName,
                      validator: validateName,
                      decoration: InputDecoration(
                          hintText: 'First Name',
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
                    child: TextFormField(
                      controller: _lastName,
                      validator: validateName,
                      decoration: InputDecoration(
                          hintText: 'Last Name',
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
                      controller: _email,
                      validator: validateFormEmail,
                      decoration: InputDecoration(
                          hintText: 'Email',
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: InternationalPhoneNumberInput(
                      textFieldController: _phoneNumber,
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
                      child:  isLoading ? CircularProgressIndicator(color: Colors.white,) :Text("Sign Up", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 19
                      ),),
                      onPressed: ()async{

                        setState(() => isLoading = true);
                        if(_key.currentState.validate()){
                          try{
                            storage(File(imageFile.path));
                            if(imageFile == null )
                              flutterToast('Image cannot be empty');
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: _email.text.trim(),
                                password: _password.text.trim());
                            errorMessage ='';
                            final _user =FirebaseAuth.instance.currentUser.uid;
                            await FirebaseFirestore.instance.collection("user profile").
                            doc(_user).set({
                              "First name": _firstName.text,
                              "Last name": _lastName.text,
                              'email': _email.text,
                              'password': _password.text,
                              'time': DateTime.now(),
                              "uid" : FirebaseAuth.instance.currentUser.uid,
                              'phoneNum': _phoneNumber.text,
                              'imageUrl': imageUrl
                            }).then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Screen()));
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
                            "Already have an account?",
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
                                  Navigator.push(context, MaterialPageRoute(builder: (_) =>LogInScreen()));
                              },
                              child: Text(
                                "Log In",
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

  /// Get from gallery
  // _getFromGallery() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(picked.path);
  //     });
  //   }
  // }
  ///send image to FirebaseStorage
  Future storage(img) async {
    print("............");
    Reference reference = FirebaseStorage.instance.ref().child("ProfileImages");
    UploadTask uploadTask = reference.child("${DateTime.now()}.jpg").putFile(img);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
  }
}

String validateName(String formName){
  if(formName == null || formName.isEmpty)
    return 'Name is required';
  if(formName.length < 6)
    return "Name length cannot be less than 6";
  return null;
}
String validateFormEmail(String email){
  if(email == null || email.isEmpty)
    return 'Email address is required';
  String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(email)) return 'Invalid E-mail Address format.';
  return null;
}
String validatePassword(String formPassword){
  if(formPassword == null || formPassword.isEmpty)
    return 'Password is required';
  if(formPassword.length < 6)
    return 'Password is to weak';
  return null;
}