part of '../tools/tools.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = true;
  var _isLoading = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController c_password = TextEditingController();
  var namevalid;
  var emailvalid;
  var passwordvalid;
  String _role;

  void register() {
    setState(() {
      _isLoading = true;
    });
    registerMember(name.text, email.text, password.text, c_password.text, _role,
            _image)
        .then((value) {
      if (value == true) {
        setState(() {
          _isLoading = false;
        });
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Member Success Added",
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
          _isLoading = false;
        });
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Member Added Failed",
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
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: HexColor("#305a84"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                  "Register",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: displayHeight(context) * 0.04,
                      fontWeight: FontWeight.bold),
                ))),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            Card(
              elevation: 4.0,
              color: Colors.white,
              margin: EdgeInsets.only(left: 20, right: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: name,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.people_alt,
                            color: Colors.grey,
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (nameValue) {
                          if (nameValue.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          namevalid = nameValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: email,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
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
                            return 'Please Enter Your Email';
                          }
                          emailvalid = emailValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: password,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (passwordValue) {
                          if (passwordValue.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          passwordvalid = passwordValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: c_password,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey,
                          ),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (passwordValue) {
                          if (passwordValue.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          passwordvalid = passwordValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      DropdownButton(
                        hint: _role == null
                            ? Text('Role')
                            : Text(
                                _role,
                                style: TextStyle(color: Colors.black),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.black),
                        items: ['admin', 'penjual', 'anggota'].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _role = val;
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 10),
                            child: _image == null
                                ? Text('Select Profile Image.',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ))
                                : Text(
                                    'Profile Image',
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
                              borderRadius: new BorderRadius.circular(5.0)),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      Text(
                        "By clicking register you accept with our terms and condition",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
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
                                color: Colors.redAccent[200],
                                disabledColor: Colors.grey,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            if (_isLoading)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 10,
                                          right: 10),
                                      child: CircularProgressIndicator()),
                                  color: HexColor("#305a84"),
                                  disabledColor: Colors.grey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    register();
                                  },
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      'Register',
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
                                      if (_image != null) {
                                        register();
                                      } else{
                                        Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: "Failed",
                                        desc: "Please input Profile image",
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
                                    }
                                  }
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
