part of 'auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = true;
  var _isLoading = false;
  bool _loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obscureText = true;
  var emailvalid;
  var passwordvalid;
  final _formKey = GlobalKey<FormState>();

  String token;
  final storage = new FlutterSecureStorage();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void initState() {
    super.initState();
  }

  void klikLogin() {
    setState(() {
      _isLoading = true;
    });
    // print("asd");
    loginUser(email.text, password.text).then((value) {
      setState(() {
        // print("Bisa DIklik");
        if (value == false) {
          setState(() {
            _isLoading = false;
          });
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Silahkan Verifikasi Email Anda",
            desc:
                "Kami telah mengirimkan verifikasi ke email yang anda daftarkan pada kami",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pop(context);
                },
                width: 120,
              )
            ],
          ).show();
        } else {
          if (value == true) {
            setState(() {
              _isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetRole()),
            );
          } else {
            setState(() {
              _isLoading = false;
            });
            Alert(
              context: context,
              type: AlertType.error,
              title: "Login Gagal",
              desc: "Periksa Email dan Password Anda",
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
      });
    });
  }

  void getDataLogin() {
    UserViewModel().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _buildWidget());
  }

  Widget _buildWidget() {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: displayHeight(context) * 0.38,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/aboutus.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(80, 50),
                    bottomRight: Radius.elliptical(80, 50),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.08,
                      ),
                      Container(
                        height: displayHeight(context) * 0.2,
                        width: displayHeight(context) * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.lightBlue[100],
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/app/icon_trs.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Kaufen",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: displayHeight(context) * 0.05,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  )
                ],
              )),
          Container(
            // decoration: BoxDecoration(
            //     color: HexColor("#e3e3e3"),
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.elliptical(80, 50),
            //       topRight: Radius.elliptical(80, 50),
            //     )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                          return 'Silahkan Masukan Email Anda';
                        }
                        emailvalid = emailValue;
                        return null;
                      },
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.03,
                    ),
                    TextFormField(
                      controller: password,
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Color(0xFF9b9b9b),
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color(0xFF9b9b9b),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      validator: (passwordValue) {
                        if (passwordValue.isEmpty) {
                          return 'Silahkan Masukan Password Anda';
                        }
                        passwordvalid = passwordValue;
                        return null;
                      },
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        "By Clicking login you agree with our Terms and Conditions",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.05,
                        ),
                        if (_isLoading)
                          FlatButton(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 15, right: 15),
                                child: CircularProgressIndicator()),
                            color: HexColor("#7eadd2"),
                            disabledColor: Colors.grey,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: () {},
                            // onPressed: () {
                            //   if (_formKey.currentState.validate()) {
                            //     print('login dipencet');
                            //   }
                            // },
                          )
                        else
                          FlatButton(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 15, right: 15),
                              child: Text(
                                'Login',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            color: HexColor("#7eadd2"),
                            disabledColor: Colors.grey,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: () {
                              _loading = true;
                              if (_formKey.currentState.validate()) {
                                klikLogin();
                                // print("asdasd");
                                // email.text = "test";
                                // password.text = "13123123";
                                // getDataLogin();
                              }
                              // print("ads");
                            },
                            // onPressed: () {
                            //   if (_formKey.currentState.validate()) {
                            //     print('login dipencet');
                            //   }
                            // },
                          ),
                      ],
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.16,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Forgot your Password ?',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: HexColor("#7eadd2"),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
