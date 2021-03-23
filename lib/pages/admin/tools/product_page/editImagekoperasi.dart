import 'dart:io';

import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/viewModel/productViewModel.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../tools.dart';
// import 'otherProduct_viewModel.dart';

class EditImageKoperasi extends StatefulWidget {
  final String imageOld;
  final int id_oper;
  EditImageKoperasi({this.imageOld, this.id_oper});
  @override
  EditImageKoperasiState createState() => EditImageKoperasiState();
}

class EditImageKoperasiState extends State<EditImageKoperasi> {
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

  

  void initState() {
    super.initState();

  }

  void editImage() {
    setState(() {
      _loading = true;
    });
    editImagekoperasi(widget.id_oper, _image)
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
            desc: "Success Updating Image",
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
            desc: "Failed Updating Image",
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
                    "Edit Image",
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
                    Container(
                      
                      // child: Align(
                      //   // alignment: Alignment.,
                      //   child: Container(
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         color: Colors.blue,
                      //         borderRadius: BorderRadius.circular(100)),
                      //     child: Icon(
                      //       Icons.edit,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      // width: displayHeight(context) * 0.01,
                      // height: displayHeight(context) * 0.15,
                      padding: EdgeInsets.all(100),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.lightBlue[100],
                        image: new DecorationImage(
                            image: new NetworkImage(
                                'http://coperationv2.herokuapp.com/img/${widget.imageOld}'),
                            fit: BoxFit.fitHeight,
                            scale: 2),
                      ),
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
                                      ? Text('Select New Product Image.',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                          ))
                                      : Text(
                                          'New Image Has been Select',
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
                                        editImage();
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
