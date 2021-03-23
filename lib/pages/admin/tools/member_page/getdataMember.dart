import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import '../viewModel/memberlistViewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../tools.dart';

class GetDatamember extends StatefulWidget {
  final String nameoper;
  final String posisioper;
  final int userid_oper;
  GetDatamember({this.nameoper, this.userid_oper, this.posisioper});

  @override
  GetDatamemberState createState() => GetDatamemberState();
}

class GetDatamemberState extends State<GetDatamember> {
  bool _isChecked = true;
  var _loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController posisi = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();

  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();

  var emailvalid;
  var alamatvalid;
  var no_telpvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    name.text = widget.nameoper;
  }

  void makeData(user_id) {
    setState(() {
      _loading = true;
    });
    makeMemberData(name.text, alamat.text, no_telp.text, selectedDate, user_id)
        .then((value) {
      setState(() {
        // print("Bisa DIklik");
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success Saving Data",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GetRole()),
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
            desc: "Failed Saving Data",
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
        tanggalLahir.text = picked.toString();
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
                    "Complete Profile",
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
                margin: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0.0),
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
                                suffixIcon: Icon(
                                  Icons.people,
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
                              controller: alamat,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.location_pin,
                                  color: Colors.grey,
                                ),
                                hintText: "Address",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (alamatValue) {
                                if (alamatValue.isEmpty) {
                                  return 'Input valid Address';
                                }
                                alamatvalid = alamatValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: no_telp,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.call,
                                  color: Colors.grey,
                                ),
                                hintText: "Phone Number",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (notelpValue) {
                                if (notelpValue.isEmpty) {
                                  return 'Enter valid Phone Number';
                                }
                                no_telpvalid = notelpValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: tanggalLahir,
                              onTap: () {
                                _selectDate(context);
                              },
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                hintText: "Date of Birth",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (notelpValue) {
                                if (notelpValue.isEmpty) {
                                  return 'Enter valid Date of Birth';
                                }
                                no_telpvalid = notelpValue;
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
                                        'Save Data',
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
                                        makeData(widget.userid_oper);
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
