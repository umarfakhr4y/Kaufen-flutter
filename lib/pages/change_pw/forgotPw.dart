import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/change_pw/v_model/profile_vmodel.dart';
import 'package:end_project/welcome.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassw extends StatefulWidget {
  final String emailoper;
  var _loading = false;

  ForgotPassw({
    this.emailoper,
  });
  @override
  ForgotPasswState createState() => ForgotPasswState();
}

class ForgotPasswState extends State<ForgotPassw> {
  bool _isChecked = true;
  bool _loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController current_password = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();

  var emailvalid;
  var passwordvalid;
  var cnfnewpasswordvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    email.text = widget.emailoper;
  }

  void logoutIni() {
    logOut().then((value) {
      setState(() {
        if (value == "logout") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
            (Route<dynamic> route) => false,
          );
        }
      });
    });
  }

  void updatePassw() {
    setState(() {
      _loading = true;
    });
    editPassw(current_password.text, password.text, confirm_password.text)
        .then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc:
                "Success Changing Password, You will be redirect to Login Page",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  logoutIni();
                  // Navigator.pop(context);
                },
                width: 120,
              )
            ],
          ).show();
        } else {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.error,
            title: "Failed",
            desc: "Failed to change your password",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: HexColor("#305a84"),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
              height: displayHeight(context) * 0.2,
              decoration: BoxDecoration(
                  color: HexColor("#ffffff"),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(80, 50),
                    bottomRight: Radius.elliptical(80, 50),
                  )),
              child: Center(
                  child: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: displayHeight(context) * 0.05,
                    fontWeight: FontWeight.bold),
              ))),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: Colors.grey,
                  ),
                ]),
            margin: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                SizedBox(
                  height: 3,
                  width: 90,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          enabled: false,
                          controller: email,
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            hintText: "Current Password",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (emailValue) {
                            if (emailValue.isEmpty) {
                              return 'Enter valid old Password';
                            }
                            emailvalid = emailValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        TextFormField(
                          controller: current_password,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            hintText: "Current Password",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (emailValue) {
                            if (emailValue.isEmpty) {
                              return 'Enter valid old Password';
                            }
                            emailvalid = emailValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        Divider(),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            hintText: "Enter New Password",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (passwordValue) {
                            if (passwordValue.isEmpty) {
                              return 'Enter valid new Password';
                            }
                            if (passwordValue.length < 8) {
                              return 'Please enter password more than 8 words';
                            }
                            passwordvalid = passwordValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        TextFormField(
                          controller: confirm_password,
                          obscureText: true,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.grey,
                            ),
                            hintText: "Confirm New Password",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (cnfnewpassw) {
                            if (cnfnewpassw.isEmpty) {
                              return 'Confirm Your New Password';
                            }
                            if (cnfnewpassw != password.text)
                              return 'Please enter same password';
                            cnfnewpasswordvalid = cnfnewpassw;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: displayHeight(context) * 0.05,
                            ),
                            FlatButton(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, left: 5, right: 5),
                                child: Text(
                                  'Back',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              color: Colors.red,
                              disabledColor: Colors.grey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                Navigator.pop(context);
                                // print("ads");
                              },
                              // onPressed: () {
                              //   if (_formKey.currentState.validate()) {
                              //     print('login dipencet');
                              //   }
                              // },
                            ),
                            if (_loading)
                              Align(
                                alignment: Alignment.topLeft,
                                child: FlatButton(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          left: 5,
                                          right: 5),
                                      child: CircularProgressIndicator()),
                                  color: Colors.lightBlue[200],
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      print('login dipencet');
                                      updatePassw();
                                      logoutIni();
                                    }
                                  },
                                ),
                              )
                            else
                              Align(
                                alignment: Alignment.topLeft,
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12, bottom: 12, left: 5, right: 5),
                                    child: Text(
                                      'Change Password',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  color: Colors.lightBlue[200],
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      print('login dipencet');
                                      updatePassw();
                                    }
                                  },
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}
