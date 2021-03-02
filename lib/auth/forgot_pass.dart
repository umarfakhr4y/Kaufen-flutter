import 'dart:ui';

import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/welcome.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  bool _isChecked = true;
  var _loading = false;
  TextEditingController email = TextEditingController();

  bool _obscureText = true;
  var emailvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  void resetPW() {
    // print("asd");
    setState(() {
      _loading = true;
    });
    forgotPW(email.text).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Link for reseting your password has been sent to your email",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                    (Route<dynamic> route) => false,
                  );
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
            desc: "Failed sending link to your email",
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

  // if (value == true) {
  //   if (value == true) {
  //     Alert(
  //       context: context,
  //       type: AlertType.success,
  //       title: "Sukses",
  //       desc: "Sukses Mengubah Data",
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "Ok",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           onPressed: () {
  //             Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(builder: (context) => AdminPage()),
  //               (Route<dynamic> route) => false,
  //             );
  //             // Navigator.pop(context);
  //           },
  //           width: 120,
  //         )
  //       ],
  //     ).show();
  //   } else {
  //     Alert(
  //       context: context,
  //       type: AlertType.error,
  //       title: "Gagal",
  //       desc: "Gagal Mengubah Data",
  //       buttons: [
  //         DialogButton(
  //           child: Text(
  //             "Ok",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           onPressed: () => Navigator.pop(context),
  //           width: 120,
  //         )
  //       ],
  //     ).show();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("#305a84"),
      body: Column(
        children: [
          Container(
              height: displayHeight(context) * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(80, 50),
                bottomRight: Radius.elliptical(80, 50),
              )),
              child: Center(
                  child: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: displayHeight(context) * 0.1,
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
            margin: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Center(
                  child: Text("Reset Password",
                      style: TextStyle(
                        fontSize: displayHeight(context) * 0.025,
                      )),
                ),
                Divider(),
                SizedBox(
                  height: 3,
                  width: 90,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: email,
                            style: TextStyle(color: Color(0xFF000000)),
                            cursorColor: Color(0xFF9b9b9b),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Email",
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Color(0xFF9b9b9b),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            validator: (emailValue) {
                              if (emailValue.isEmpty) {
                                return 'Please enter valid email';
                              }
                              emailvalid = emailValue;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: displayHeight(context) * 0.05,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: FlatButton(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                              left: 5,
                                              right: 5),
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
                                                new BorderRadius.circular(
                                                    20.0)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: displayHeight(context) * 0.01,
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
                                              child:
                                                  CircularProgressIndicator()),
                                          color: Colors.lightBlue[200],
                                          disabledColor: Colors.grey,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          onPressed: () {},
                                        ),
                                      )
                                    else
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: FlatButton(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 12,
                                                bottom: 12,
                                                left: 5,
                                                right: 5),
                                            child: Text(
                                              'Send',
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
                                                  new BorderRadius.circular(
                                                      20.0)),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              resetPW();
                                            }
                                          },
                                        ),
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
