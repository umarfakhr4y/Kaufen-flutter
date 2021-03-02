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
            Alert(
              context: context,
              type: AlertType.success,
              title: "Login Berhasil",
              buttons: [
                DialogButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GetRole()),
                    );
                    // Navigator.pop(context);
                  },
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
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: _floatingPanel(),
        collapsed: _floatingCollapsed(),
        parallaxEnabled: true,
        parallaxOffset: 0.2,
        body: Column(
          children: [
            Container(
                height: displayHeight(context) * 0.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
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
                          height: displayHeight(context) * 0.15,
                        ),
                        Container(
                          height: displayHeight(context) * 0.2,
                          width: displayHeight(context) * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.lightBlue[100],
                            image: new DecorationImage(
                              image: new ExactAssetImage(
                                  'assets/app/icon_trs.png'),
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
          ],
        ),
      ),
    );
  }

  Widget _floatingCollapsed() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0.0),
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          SizedBox(
            height: displayHeight(context) * 0.0025,
            width: displayHeight(context) * 0.09,
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
          ),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          Text(
            "Swipe Up To Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }

  Widget _floatingPanel() {
    return Container(
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
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
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
                    height: displayHeight(context) * 0.02,
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
                      "Dengan meng-klik Login anda sepakat dengan syarat dan Ketentuan kami",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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
                      if (_isLoading)
                        FlatButton(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 15, right: 15),
                              child: CircularProgressIndicator()),
                          color: HexColor("#305a84"),
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
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: HexColor("#305a84"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 10, right: 10),
                          child: Text(
                            'Forgot Password',
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
                            borderRadius: new BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
