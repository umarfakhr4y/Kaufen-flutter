import 'dart:convert';
import 'dart:io';

import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:end_project/pages/admin/tools/otherproduct_page/otherProduct_viewModel.dart';
import 'package:end_project/pages/admin/tools/product_page/model/koperasi.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class Addproduct extends StatefulWidget {
  @override
  AddproductState createState() => AddproductState();
}

class AddproductState extends State<Addproduct> {
  String token;
  final storage = new FlutterSecureStorage();
  bool _isChecked = true;
  var _loading = false;
  TextEditingController nameBarang = TextEditingController();
  TextEditingController stock = TextEditingController();

  TextEditingController harga = TextEditingController();

  bool _obscureText = true;
  String _jenisFix;

  List _dataPeniitip = ["alat", "makanan", "minuman"]; //Array gender

  DateTime selectedDate = DateTime.now();

  var barangvalid;
  var stockvalid;
  var jenisvalid;
  var hargavalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
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

  void tambahproduk() {
    setState(() {
      _loading = true;
    });
    addProduct(nameBarang.text, _jenisFix, stock.text, harga.text, _image)
        .then((value) {
      if (value == true) {
        setState(() {
          _loading = false;
        });
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Product Success Added",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
                (Route<dynamic> route) => false,
              ),
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
          title: "Faied",
          desc: "Product Failed Added",
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
                    "Add Kaufen Product",
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                hintText: "Product Name",
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (barangValue) {
                                if (barangValue.isEmpty) {
                                  return 'Enter valid Product name';
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
                                  return 'Enter valid Stock';
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
                                items: _dataPeniitip.map((item) {
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
                                  return 'Enter valid product price';
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
                                          'Add Product',
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
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          if (_image == null) {
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "Failed",
                                              desc: "Please Input Image",
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
                                          } else {
                                            tambahproduk();
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
