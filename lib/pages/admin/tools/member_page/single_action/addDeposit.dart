import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/viewModel/action.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../viewModel/memberlistViewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../tools.dart';

class AddDeposit extends StatefulWidget {
  @override
  final String nameoper;
  final int id;
  AddDeposit({this.nameoper, this.id});

  AddDepositState createState() => AddDepositState();
}

class AddDepositState extends State<AddDeposit> {
  String _role;
  DateTime selectedDate = DateTime.now();

  bool _isChecked = true;
  var _loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController total = TextEditingController();

  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    name.text = widget.nameoper;
  }

  void makeDeposits() {
    setState(() {
      _loading = true;
    });
    makeDeposit(total.text, widget.id).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success in Adding Deposit",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
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
            desc: "Failed in Adding Deposit",
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
                    "Add Deposit",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: displayHeight(context) * 0.04,
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
                              controller: name,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Savers",
                                suffixIcon: Icon(
                                  Icons.people,
                                  color: Colors.grey,
                                ),
                                hintText: "name",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (emailValue) {
                                if (emailValue.isEmpty) {
                                  return 'Tidak Ada Name';
                                }
                                emailvalid = emailValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: total,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Saved Ammount",
                                suffixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ),
                                hintText: "Saved Ammount",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (passwordValue) {
                                if (passwordValue.isEmpty) {
                                  return 'Please enter valid value';
                                }
                                passwordvalid = passwordValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
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
                                          'Make Deposit',
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
                                          makeDeposits();
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
        ));
  }
}
