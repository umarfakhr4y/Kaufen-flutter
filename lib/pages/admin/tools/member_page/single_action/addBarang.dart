import 'dart:io';

import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/viewModel/action.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/viewModel/add_titipan_member.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewModel/memberlistViewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../tools.dart';

class AddBarangs extends StatefulWidget {
  @override
  final String nameoper;
  final int id;
  AddBarangs({this.nameoper, this.id});

  AddBarangsState createState() => AddBarangsState();
}

class AddBarangsState extends State<AddBarangs> {
  String _role;
  DateTime selectedDate = DateTime.now();

  bool _isChecked = true;
  var _loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController namaBarang = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController harga = TextEditingController();

  bool _obscureText = true;
  var namevalid;
  var barangvalid;
  var stockvalid;
  var jenisvalid;
  var hargavalid;

  final _formKey = GlobalKey<FormState>();
  List _dataType = ["alat", "makanan", "minuman"]; //Array gender
  String _jenisFix;

  void initState() {
    super.initState();
    name.text = widget.nameoper;
  }

  void makeBarangs() {
    setState(() {
      _loading = true;
    });
    makeBarang(namaBarang.text, stock.text, _jenisFix, harga.text,
            widget.id, _image)
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
            desc: "Success Adding Goods",
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
            desc: "Failed Adding Goods",
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
        print(picked);
      });
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
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
                    "Add Goods",
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
                margin: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
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
                                hintText: "name",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (nameValue) {
                                if (nameValue.isEmpty) {
                                  return 'Tidak Ada Name';
                                }
                                namevalid = nameValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            TextFormField(
                              controller: namaBarang,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Goods Name",
                                suffixIcon: Icon(
                                  Icons.auto_awesome,
                                  color: Colors.grey,
                                ),
                                hintText: "Goods Name",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (barangValue) {
                                if (barangValue.isEmpty) {
                                  return 'Enter Goods Name';
                                }
                                barangvalid = barangValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            TextFormField(
                              controller: stock,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Goods Stock",
                                suffixIcon: Icon(
                                  Icons.confirmation_number_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: "Goods Stock",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (stockValue) {
                                if (stockValue.isEmpty) {
                                  return 'Enter Total Stock';
                                }
                                stockvalid = stockValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: DropdownButton(
                                hint: Text("Select Type"),
                                value: _jenisFix,
                                items: _dataType.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jenisFix = value;
                                    print(_jenisFix);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            TextFormField(
                              controller: harga,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Goods Price",
                                suffixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ),
                                hintText: "Goods Price",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (hargaValue) {
                                if (hargaValue.isEmpty) {
                                  return 'Enter Goods Price';
                                }
                                hargavalid = hargaValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
                                  child: _image == null
                                      ? Text('Select Product Image.',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ))
                                      : Text(
                                          'Product Image',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                ),
                                color: Colors.grey,
                                disabledColor: Colors.grey,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                                onPressed: () {
                                  getImage();
                                },
                              ),
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
                                  },
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
                                          'Add Goods',
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
                                          if (_image != null) {
                                            makeBarangs();
                                          } else {
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "Failed",
                                              desc:
                                                  "Please input Profile image",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  width: 120,
                                                )
                                              ],
                                            ).show();
                                          }
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
