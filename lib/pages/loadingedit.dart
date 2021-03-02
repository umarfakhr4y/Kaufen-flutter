import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../profile_viewmodel.dart';
import 'editProfile.dart';

class LoadingEdit extends StatefulWidget {
  final String nameoper;
  final String emailoper;

  LoadingEdit({
    this.nameoper,
    this.emailoper,
  });

  @override
  LoadingEditState createState() => LoadingEditState();
}

class LoadingEditState extends State<LoadingEdit> {
  bool _isChecked = true;
  bool _loading = false;
  List dataMember;

  
  // TextEditingController tanggal_lahir = TextEditingController();

  List dataname;

  String token;
  final storage = new FlutterSecureStorage();

  bool _obscureText = true;
  DateTime selectedDate = DateTime.now();

  // var no_telpvalid;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    getDataname(widget.nameoper);
    print(widget.emailoper);

    print(widget.nameoper);
  }

  void getDataname(namedata) {
    getdataprofilee(namedata).then((value) {
      setState(() {
        dataname = value;

        if (dataname != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditProfile(
              nameoper: widget.nameoper,
              emailoper: widget.emailoper,

              alamat: dataname[0].alamat,
              notelp: dataname[0].noTelp,
              tgl_lahirr: dataname[0].tanggalLahir,
            );
            ;
          }));
        } else {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
