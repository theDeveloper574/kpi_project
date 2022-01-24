import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'Fill_page.dart';
import 'mobile_logIn.dart';

class OTPSc extends StatefulWidget {
  final String phone;
  OTPSc(this.phone);
  @override
  _OTPScState createState() => _OTPScState();
}
class _OTPScState extends State<OTPSc> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String verCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("OTP verification"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Verify Phone +92 ${widget.phone}", style: TextStyle(
                    color: Colors.black45,
                    fontSize: 19
                ),),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child: PinPut(
                fieldsCount: 6,
                eachFieldHeight: 40.0,
                withCursor: true,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.deepPurpleAccent.withOpacity(.5),
                  ),
                ),
                keyboardType: TextInputType.number,
                onSubmit: (pin)async{
                  try{
                    await FirebaseAuth.instance.signInWithCredential(
                        PhoneAuthProvider.credential(verificationId: verCode,
                            smsCode: pin)).then((value){
                      if(value != null){
                        print("null value");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>FillPage()),
                                (route) => false);
                      }
                    });
                  }catch(e){
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Invalid OTP")));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  verifyPhone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+92 ${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential)async{
          await FirebaseAuth.instance.signInWithCredential(credential)
              .then((value)async{
            if(value.user !=null){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LogIn()),(route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationId, int resendToken){
          setState(() {
            verCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          setState(() {
            verCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60)
    );
  }
  @override
  void initState(){
    super.initState();
    verifyPhone();
  }
}