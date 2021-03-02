import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../tools.dart';
import 'otherProduct_viewModel.dart';

class EditOtherProduct extends StatefulWidget {
  final String nameoper;
  final String nameBarangoper;
  final String jenisoper;
  final String stockoper;
  final String hargaoper;
  final int idoper;
  final int user_idoper;
  EditOtherProduct({
    this.nameoper,
    this.nameBarangoper,
    this.jenisoper,
    this.stockoper,
    this.hargaoper,
    this.idoper,
    this.user_idoper,
  });

  @override
  EditOtherProductState createState() => EditOtherProductState();
}

class EditOtherProductState extends State<EditOtherProduct> {
  bool _isChecked = true;
  var _loading = false;
  TextEditingController nameBarang = TextEditingController();
  
  TextEditingController stock = TextEditingController();
  TextEditingController harga = TextEditingController();

  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;

  final _formKey = GlobalKey<FormState>();

  String _jenisFix;
  List _dataType = ["alat", "makanan", "minuman"]; //Array gender
  int _userId;


  String _penitipFix;
  List<dynamic> _dataPeniitip = List();

  void getPenitip() {
    getSingleMemberUser().then((value) {
      setState(() {
        _dataPeniitip = value;
      });
    });
  }

  void initState() {
    super.initState();
    _penitipFix = widget.nameoper;
    nameBarang.text = widget.nameBarangoper;
    _jenisFix = widget.jenisoper;
    stock.text = widget.stockoper;
    harga.text = widget.hargaoper;
    getPenitip();
  }

  void editProductbyid(id) {
    setState(() {
      _loading = true;
    });
    editTitipan(nameBarang.text, _jenisFix, stock.text,
            harga.text, id)
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
            desc: "Success Editing Data",
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
            desc: "Failed Editing Data",
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
                    "Edit Goods",
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: nameBarang,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Goods Name",
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
                              validator: (emailValue) {
                                if (emailValue.isEmpty) {
                                  return 'Please Enter valid goods Name';
                                }
                                emailvalid = emailValue;
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
                              controller: stock,
                              style: TextStyle(color: Color(0xFF000000)),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Stock",
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
                              validator: (passwordValue) {
                                if (passwordValue.isEmpty) {
                                  return 'Enter Valid Stock';
                                }
                                passwordvalid = passwordValue;
                                return null;
                              },
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
                                labelText: "Price",
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
                              validator: (passwordValue) {
                                if (passwordValue.isEmpty) {
                                  return 'Enter Valid Price';
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
                                          top: 12,
                                          bottom: 12,
                                          left: 5,
                                          right: 5),
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
                                    alignment: Alignment.topRight,
                                    child: FlatButton(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                              left: 5,
                                              right: 5),
                                          child: CircularProgressIndicator()),
                                      color: HexColor("#305a84"),
                                      disabledColor: Colors.grey,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      onPressed: () {},
                                    ),
                                  )
                                else
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: FlatButton(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 5,
                                            right: 5),
                                        child: Text(
                                          'Save',
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
                                          editProductbyid(widget.idoper);
                                          // print(widget.hargaoper);
                                          // print(widget.idoper);
                                          // print(widget.jenisoper);
                                          // print(widget.nameoper);
                                          // print(widget.stockoper);

                                          // makeData(widget.userid_oper);

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
