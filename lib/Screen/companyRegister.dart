import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Screen/verifyCompany.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompanyRegister extends StatefulWidget {
  @override
  _CompanyRegisterState createState() => _CompanyRegisterState();
}

class _CompanyRegisterState extends State<CompanyRegister> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  PickedFile _logo;
  String _logoImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Registration'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: _logo == null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: Text("enter company logo"),
                        )
                      : ClipOval(
                          child: Image.file(
                          File(_logo.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                        )),
                ),
                Positioned(
                  bottom: 0,
                  right: 8,
                  child: GestureDetector(
                      onTap: () async {
                        final image = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        setState(() {
                          _logo = image;
                        });
                      },
                      child: Icon(Icons.camera_alt_rounded)),
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
                controller: _phone,
                decoration: InputDecoration(
                    hintText: 'Phone', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
              child: TextFormField(
                controller: _address,
                decoration: InputDecoration(
                    hintText: 'Address', border: InputBorder.none),
              ),
            ),
            InkWell(
              onTap: () async {
                ///upload photo to storage
                await storage(File(_logo.path));

                ///generate user random UID
                final gen = DateTime.now();
                final id = gen.microsecondsSinceEpoch.toString();
                final res = id.substring(10);
                print(id);
                print(res);
                await FirebaseFirestore.instance
                    .collection('Company ID')
                    .doc(res)
                    .set({'company id': res});

                ///upload data to fire store firebase
                try {
                  await FirebaseFirestore.instance
                      .collection('register company')
                      .doc(res)
                      .collection("company info")
                      .doc(DateTime.now().toString())
                      .set({
                    'name': _name.text,
                    'email': _email.text,
                    'phone': _phone.text,
                    'address': _address.text,
                    'doc uid ': DateTime.now().toString(),
                    'company logo': _logoImage,
                    'generate uid': res
                  });
                } on FirebaseException catch (e) {
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
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have a company? '),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCompany()));
                  },
                  child: Text(
                    'Verify',
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
    Reference reference = FirebaseStorage.instance.ref().child("company logo");
    UploadTask uploadTask =
        reference.child("${DateTime.now()}.jpg").putFile(img);
    TaskSnapshot snapshot = await uploadTask;
    _logoImage = await snapshot.ref.getDownloadURL();
    print(_logoImage);
  }
}
