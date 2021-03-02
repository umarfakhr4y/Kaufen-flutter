import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/viewModel/action.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditLoan extends StatefulWidget {
  final String nameoper;
  final String total;
  final String raturned;
  final int id;

  EditLoan({
    this.nameoper,
    this.total,
    this.raturned,
    this.id,
  });

  @override
  EditLoanState createState() => EditLoanState();
}

class EditLoanState extends State<EditLoan> {
  bool _isChecked = true;
  var _loading = false;
  TextEditingController nameOper = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController returned = TextEditingController();
  DateTime selectedDate = DateTime.now();

  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;

  final _formKey = GlobalKey<FormState>();

  String _penitipFix;
  List<dynamic> _dataPeniitip = List();

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
        returned.text = picked.toString();
        print(picked);
      });
  }

  void initState() {
    super.initState();

    nameOper.text = widget.nameoper;
    total.text = widget.total;
    returned.text = widget.raturned;
  }

  void updateLoan() {
    setState(() {
      _loading = true;
    });
    editLoans(total.text, selectedDate.toString(), widget.id)
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
            desc: "Success in Editing Loans",
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
            desc: "Failed to Editing Loans",
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
                "Edit Loans",
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          enabled: false,
                          controller: nameOper,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Borrower",
                            suffixIcon: Icon(
                              Icons.people,
                              color: Colors.grey,
                            ),
                            hintText: "Borrower",
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
                            labelText: "Borrowed Ammount",
                            suffixIcon: Icon(
                              Icons.attach_money,
                              color: Colors.grey,
                            ),
                            hintText: "Borrowed Ammount",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (passwordValue) {
                            if (passwordValue.isEmpty) {
                              return 'Please enter valid amount';
                            }
                            passwordvalid = passwordValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        TextFormField(
                          controller: returned,
                          onTap: () {
                            _selectDate(context);
                          },
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Return Date",
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                            hintText: "Return Date",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (passwordValue) {
                            if (passwordValue.isEmpty) {
                              return 'Please enter valid return date';
                            }
                            passwordvalid = passwordValue;
                            return null;
                          },
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 90),
                              child: FlatButton(
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
                                        top: 12, bottom: 12, left: 5, right: 5),
                                    child: Text(
                                      'Update Loans',
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
                                      updateLoan();
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
