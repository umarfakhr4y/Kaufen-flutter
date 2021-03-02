import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'about_us.dart';
import 'auto_login.dart';
import 'size_helper.dart';
import 'auth/auth.dart';
import 'auth/loginLagi.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  _WelcomeState createState() => _WelcomeState();

  void clearTokenss() {
    clearToken().then((value) {
      setState(() {
        if (value == "logout") {
          print("sukses hapus token");
        }
      });
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
            ),
            child: Center(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: displayHeight(context) * 0.2),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Koperasi",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: displayHeight(context) * 0.08),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onLongPress: () {
                              clearTokenss();
                            },
                            child: Text(
                              "Simpan Pinjam",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: displayHeight(context) * 0.06),
                            ),
                          )),
                      SizedBox(height: displayHeight(context) * 0.023),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Koperasi sekaligus",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: displayHeight(context) * 0.03),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Tempat Simpan Pinjam",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: displayHeight(context) * 0.03),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.03),
                      SizedBox(
                        height: displayHeight(context) * 0.067,
                        width: displayHeight(context) * 0.23,
                        child: GestureDetector(
                            onTap: () {
                              print("asd");
                              
                            },
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // color: Colors.lightBlue[100],
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/avail.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black, BlendMode.hue),
                                  ),
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                            )),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.067,
                        width: displayHeight(context) * 0.23,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AutoLogin()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/login.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black, BlendMode.hue),
                                  ),
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                            )),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.067,
                        width: displayHeight(context) * 0.23,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/about.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black, BlendMode.hue),
                                  ),
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ))),
      ),
    );
  }
}
