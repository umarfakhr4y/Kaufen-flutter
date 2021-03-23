import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/viewModel/action.dart';
import 'package:end_project/pages/anggota/profilePage/botNavBar.dart';
import 'package:end_project/pages/anggota/tools/debt_page/action/debt_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AddSavings extends StatefulWidget {
  @override
  final int user_id;
  final int data_id;
  AddSavings({this.user_id, this.data_id});

  AddSavingsState createState() => AddSavingsState();
}

class AddSavingsState extends State<AddSavings> {
  String _role;
  DateTime selectedDate = DateTime.now();

  bool _isChecked = true;
  var _loading = false;
  // TextEditingController name = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController tanggal = TextEditingController();

  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    print(widget.user_id);
    print(widget.data_id);
    // name.text = widget.nameoper;
  }

  void makeSavings() {
    setState(() {
      _loading = true;
    });
    makeSavingsRequest(widget.data_id, widget.user_id, total.text,).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success in Adding Savings",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AnggotaPage()),
                    (Route<dynamic> route) => false,
                  );
                  // Navigator.pop(context);
                },
                width: 120,
              )
            ],
          ).show();
        } else {
          // setState(() {
          //   _loading = false;
          // });
          Alert(
            context: context,
            type: AlertType.error,
            title: "Failed",
            desc: "Failed to Add Savings",
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        tanggal.text = picked.toString();
        print(picked);
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
                    "Add Savings",
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
                              controller: total,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Total Saving",
                                suffixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ),
                                hintText: "Total Saving(IDR)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (emailValue) {
                                if (emailValue.isEmpty) {
                                  return 'Please Input Valid Total Saving';
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
                                if(_loading)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: FlatButton(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          left: 5,
                                          right: 5),
                                      child: CircularProgressIndicator()
                                    ),
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
                                        'Make Savings',
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
                                        makeSavings();
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
