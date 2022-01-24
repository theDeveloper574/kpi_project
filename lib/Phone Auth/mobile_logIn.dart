


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Phone_auth.dart';

class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _controller =TextEditingController();
  String errorMessage  = '';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text("Phone Verification", style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
            Center(
              child: Text("Please Enter Only Your Phone Number", style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Center(
              child: Text("Don't need to give Country Code", style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600
              ),),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Center(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Please Enter Your Phone Number",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.withOpacity(0.8)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.6),
                          width: 1.1
                        ),
                      ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal:10),
                      child: Text("+92",style: TextStyle(
                        fontSize:15,
                        color: Colors.grey.withOpacity(0.8)
                      ),),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Colors.red,
                        width: 1.3
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
              child: FlatButton(
                  child:Text("Next", style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),),
                onPressed: (){
                    setState(() {});
                    if(_controller.text == null || _controller.text.isEmpty|| _controller.text.length < 10){
                      return _key.currentState.showSnackBar(SnackBar(content: Text("Field cannot be empty"),));
                    }else{
                      print(_controller.text);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>OTPSc(_controller.text)));
                    }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
