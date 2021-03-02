part of 'auth.dart';

class GetRole extends StatefulWidget {
  @override
  _GetRoleState createState() => _GetRoleState();
}

class _GetRoleState extends State<GetRole> {
  void getDataLogin() {
    GetRoleVModel().getRole().then((value) {
      setState(() {
        // if (value == "verfiks") {
        //   print("blom verikasi");
        // } else
         if (value == "admin") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
            (Route<dynamic> route) => false,
          );
        } else if (value == "penjual") {
          print("PENJUAL COY");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PenjualPage()),
            (Route<dynamic> route) => false,
          );
        } else if (value == "anggota") {
          print("INI ANGGOTA");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AnggotaPage()),
            (Route<dynamic> route) => false,
          );
        }else{
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Expired()),
            (Route<dynamic> route) => false,
          );
        }
      });
    });
  }

  void initState() {
    super.initState();
    getDataLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
