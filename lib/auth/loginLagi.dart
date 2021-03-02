import 'package:end_project/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../welcome.dart';

class Expired extends StatefulWidget {
  @override
  _ExpiredState createState() => _ExpiredState();
}


class _ExpiredState extends State<Expired> {

  void clearTokenss() {
    clearToken().then((value) {
      setState(() {
        if (value == "logout") {
          print("sukses hapus token");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your Session has expired, Please Consider to login again"),
          FlatButton(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
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
            color: HexColor("#305a84"),
            disabledColor: Colors.grey,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
              clearTokenss();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
                (Route<dynamic> route) => false,
              );
            },
            // onPressed: () {
            //   if (_formKey.currentState.validate()) {
            //     print('login dipencet');
            //   }
            // },
          ),
        ],
      ),
    ));
  }
}
