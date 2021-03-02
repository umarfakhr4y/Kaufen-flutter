import 'dart:convert';
import 'dart:io';

import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:end_project/pages/admin/tools/otherproduct_page/action/addTitipan.dart';
import 'package:end_project/pages/admin/tools/otherproduct_page/otherProduct_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AddOtherproduct extends StatefulWidget {
  @override
  AddOtherproductState createState() => AddOtherproductState();
}

class AddOtherproductState extends State<AddOtherproduct> {
  String token;
  final storage = new FlutterSecureStorage();
  bool _isChecked = true;
  var _loading = false;
  TextEditingController nameBarang = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController harga = TextEditingController();

  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();

  var barangvalid;
  var stockvalid;
  var jenisvalid;
  var hargavalid;

  String _penitipFix;
  int _userId;
  String _jenisFix;
  List<dynamic> _dataPeniitip = List();

  List _dataType = ["alat", "makanan", "minuman"]; //Array gender

  final _formKey = GlobalKey<FormState>();

  void getPenitip() {
    getSingleMemberUser().then((value) {
      setState(() {
        _dataPeniitip = value;
      });
    });
  }

  void initState() {
    super.initState();
    getPenitip();
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

  void buatTitipan() {
    setState(() {
      _loading = true;
    });
    makeTitipan( nameBarang.text, stock.text, _jenisFix, harga.text, _userId, _image)
        .then((value) {
      if (value == true) {
        setState(() {
          _loading = false;
        });
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success Adding Deposited Goods",
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
          desc: "Failed Adding Deposited Product",
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
                    "Add Deposited Product",
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: DropdownButton(
                                hint: Text("Select Entrustee"),
                                value: _penitipFix,
                                items: _dataPeniitip.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item.name),
                                    value: item.name,
                                    onTap: () {
                                      setState(() {
                                        _userId = item.userId;
                                        print(_userId);
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _penitipFix = value;

                                    print(_penitipFix);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: nameBarang,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.headset,
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
                                  return 'Enter Valid Goods Name';
                                }
                                barangvalid = barangValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: stock,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.clear_all_outlined,
                                  color: Colors.grey,
                                ),
                                hintText: "Stock",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (stockValue) {
                                if (stockValue.isEmpty) {
                                  return 'Enter valid stock';
                                }
                                stockvalid = stockValue;
                                return null;
                              },
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
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
                              height: displayHeight(context) * 0.02,
                            ),
                            TextFormField(
                              controller: harga,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                ),
                                hintText: "Price",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (hargaValue) {
                                if (hargaValue.isEmpty) {
                                  return 'Enter Valid Goods Price';
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
                                          'Create Goods',
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
                                          buatTitipan();
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
