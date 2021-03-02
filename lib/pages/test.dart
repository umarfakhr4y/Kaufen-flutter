import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../size_helper.dart';
import '../auth/auth.dart';
import 'admin/tools/tools.dart';
import 'admin/profilePage/profile.dart';
import 'admin/profilePage/botNavBar.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _isChecked = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: displayHeight(context) * 0.5),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                'Login',
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
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
              
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                'Register',
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
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
              
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                'Admin',
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
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
              
            },
          ),

          
        ],
      ),
    ));
  }
}
