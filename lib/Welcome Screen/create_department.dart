import 'package:dashboard/Welcome%20Screen/resgister_company.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateDepartment extends StatefulWidget {
  @override
  _CreateDepartmentState createState() => _CreateDepartmentState();
}

class _CreateDepartmentState extends State<CreateDepartment> {
  TextEditingController _companyID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _companyID,
                        validator: validateName,
                        decoration: InputDecoration(
                            hintText: 'please enter company ID',
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
                  ),
                  FlatButton(onPressed: (){

                    print(_companyID.text.toString());
                  }, child: Text("Enter id"))
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>RegisterCompany()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          "Register Company?",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 10),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
String validateName(String formName){
  if(formName == null || formName.isEmpty)
    return 'Company Name is required';
  if(formName.length < 6)
    return "Name length cannot be less than 6";
  return null;
}