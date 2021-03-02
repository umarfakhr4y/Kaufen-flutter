import 'dart:ui';

import 'package:end_project/pages/admin/tools/member_page/getdataMember.dart';
import 'package:end_project/pages/editProfile.dart';
import 'package:end_project/welcome.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../change_pw/forgotPw.dart';
import '../../test.dart';
import '../../../auth/auth.dart';
import '../../admin/profilePage/model/profilemodel.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAnggota extends StatefulWidget {
  @override
  _ProfileAnggotaState createState() => _ProfileAnggotaState();
}

class _ProfileAnggotaState extends State<ProfileAnggota> {
  DataLogin dataLogin;
  bool _isChecked = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;

  final _formKey = GlobalKey<FormState>();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void logoutIni() {
    logOut().then((value) {
      setState(() {
        if (value == "logout") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Welcome()),
              (Route<dynamic> route) => false);
        }
      });
    });
  }

  void getDataLogin() {
    UserViewModel().getUser().then((value) {
      setState(() {
        dataLogin = value;
      });
    });
  }

  void initState() {
    super.initState();
    getDataLogin();
  }

  void deleteBySelf() {
    selfDelete().then((value) {
      setState(() {
        if (value == "success") {
          Alert(
            context: context,
            type: AlertType.success,
            title: "Sukses",
            desc: "Sukses Menghapus User",
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
          Alert(
            context: context,
            type: AlertType.error,
            title: "Gagal",
            desc: "Gagal Menghapus User",
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
      appBar: AppBar(
        title: Text("Kaufen"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
        ),
        elevation: 0,
        shadowColor: Colors.lightBlue[200],
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              logoutIni();
            },
          ),
        ],
        leading: new Container(),
      ),
      body: dataLogin == null
          ? Center(
              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.grey,
                  child: Text(
                    'Loading',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: displayHeight(context) * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  height: displayHeight(context) * 0.35,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(160, 65),
                        bottomRight: Radius.elliptical(160, 65),
                      )),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (dataLogin.success.image.contains("img_profile"))
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://coperationv2.herokuapp.com/${dataLogin.success.image}'),
                          radius: displayHeight(context) * 0.08,
                        )
                      else
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://coperationv2.herokuapp.com/${dataLogin.success.image}'),
                          radius: displayHeight(context) * 0.08,
                        ),
                      SizedBox(
                        height: displayHeight(context) * 0.03,
                      ),
                      Text(
                        '${dataLogin.success.name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: displayHeight(context) * 0.04),
                      ),
                      Text(
                        '${dataLogin.success.email}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: displayHeight(context) * 0.025),
                      )
                    ],
                  )),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (dataLogin.success.data.length <= 0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GetDatamember(
                              nameoper: dataLogin.success.name,
                              userid_oper: dataLogin.success.id,
                            );
                            ;
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditProfile(
                              nameoper: dataLogin.success.name,
                              emailoper: dataLogin.success.email,
                            );
                            ;
                          }));
                        }
                      },
                      child: new Container(
                        height: displayHeight(context) * 0.07,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              displayHeight(context) * 0.5),
                        ),
                        child: ListTile(
                            leading: SizedBox(
                                height: 100.0,
                                width: 45.0, // fixed width and height
                                child: Icon(Icons.edit)),
                            title: Text((() {
                              if (dataLogin.success.data.length <= 0) {
                                return "Complete Profile";
                              } else {
                                return "Edit Profile";
                              }
                            })())),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassw(
                                    emailoper: dataLogin.success.email,
                                  )),
                        );
                      },
                      child: new Container(
                        height: displayHeight(context) * 0.07,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              displayHeight(context) * 0.5),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                              height: 100.0,
                              width: 45.0, // fixed width and height
                              child: Icon(Icons.vpn_key)),
                          title: Text(
                            'Change Password',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Warning",
                          desc: "Anda Yakin Ingin Menghapus User ?",
                          buttons: [
                            DialogButton(
                              color: Colors.red,
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              width: 120,
                            ),
                            DialogButton(
                              child: Text(
                                "Yakin",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                deleteBySelf();
                                logoutIni();
                              },
                              width: 120,
                            )
                          ],
                        ).show();
                      },
                      child: new Container(
                        height: displayHeight(context) * 0.07,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              displayHeight(context) * 0.5),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                              height: 100.0,
                              width: 45.0, // fixed width and height
                              child: Icon(Icons.delete)),
                          title: Text(
                            'Delete Account',
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        print("Logout Di klik");
                        logoutIni();
                      },
                      child: new Container(
                        height: displayHeight(context) * 0.07,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              displayHeight(context) * 0.5),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                              height: 100.0,
                              width: 45.0, // fixed width and height
                              child: Icon(Icons.logout)),
                          title: Text(
                            'Logout',
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
