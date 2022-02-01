import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Screen/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PickedFile _image;
  String _imageUrl;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: _image == null
                      ? SizedBox()
                      : ClipOval(
                          child: Image.file(
                          File(_image.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                        )),
                ),
                Positioned(
                  bottom: 0,
                  right: 8,
                  child:
                      GestureDetector(onTap: ()async{
                        final pickImage= await ImagePicker().getImage(source: ImageSource.gallery);
                        setState(() {
                          _image = pickImage;
                        });
                      }, child: Icon(Icons.camera)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _name,
                decoration:
                    InputDecoration(hintText: 'Name', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: 'Email', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                    hintText: 'Password', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _phone,
                decoration: InputDecoration(
                    hintText: 'Phone', border: InputBorder.none),
              ),
            ),
            InkWell(
              onTap: ()async{
                try{
                 await storage(File(_image.path));
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email.text.trim(),
                      password: _password.text.trim());
                  final _user = FirebaseAuth.instance.currentUser.uid;
                  await FirebaseFirestore.instance.collection("user porfile").doc(_user)
                      .set({
                      'name': _name.text,
                    'email': _email.text,
                    'password': _password.text,
                    'phone': _phone.text,
                    'doc id': _user,
                  'imageURL': _imageUrl
                  }).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Welcome()));
                  });
                }catch(e){
                  print(e);
                }
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: 15, top: 30),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? '),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future storage(img) async {
    print("............");
    Reference reference = FirebaseStorage.instance.ref().child("ProfileImages");
    UploadTask uploadTask = reference.child("${DateTime.now()}.jpg").putFile(img);
    TaskSnapshot snapshot = await uploadTask;
    _imageUrl = await snapshot.ref.getDownloadURL();
    print(_imageUrl);
  }
}
