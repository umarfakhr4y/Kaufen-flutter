import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/model/profilemodel.dart';
import 'package:end_project/pages/admin/tools/saving_page/saving_vmodel.dart';
import 'package:end_project/pages/admin/tools/viewModel/memberlistViewmodel.dart';
import 'package:end_project/pages/anggota/profilePage/botNavBar.dart';
import 'package:end_project/pages/anggota/tools/debt_page/action/debt_viewmodel.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '';

import '../../../../size_helper.dart';
import 'model/savingmodeladmin.dart';


class SavingListAdmin extends StatefulWidget {
  @override
  SavingListMembeAdmin createState() => SavingListMembeAdmin();
}

class SavingListMembeAdmin extends State<SavingListAdmin> {
  TextEditingController editingController = TextEditingController();
  // final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');
  final currencyFormatter = new NumberFormat.currency(locale: 'ID');
  TextEditingController pay = TextEditingController();
  var _loading = false;

  void initState() {
    super.initState();
    dataNya();
  }

  // DataLogin dataLogin;
  Adminsavings dataAdminSave;

  int user_id;
  int dataIdd;
  String namenya;

  // void getNameNya() {
  //   getName().then((value) {
  //     setState(() {
  //       dataLogin = value;
  //       user_id = dataLogin.success.id;
  //       dataIdd = dataLogin.success.data[0].id;
  //       namenya = dataLogin.success.name;
  //       dataNya();
  //       // print(user_id);
  //       // print(dataIdd);
  //       // print(namenya);
  //       // dataNya();
  //     });
  //   });
  // }

  void dataNya() {
    getSavingss().then((value) {
      setState(() {
        dataAdminSave = value;
        // print(dataAdminSave);
        // print(dataAdminSave[0].tanggal_Lahir);
      });
    });
  }



  void decreasingDebt(int lama, int id) {
    setState(() {
      _loading = true;
    });
    payDebt(int.parse(pay.text), lama, id).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success Paying Debt",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AnggotaPage()),
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
            desc: "Failed Paying Debt",
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
        appBar: AppBar(
            title: Text("Kaufen"),
            actions: [
              
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
            ),
            elevation: 0,
            shadowColor: Colors.lightBlue[200],
            // actions: <Widget>[
            //   new IconButton(
            //     icon: new Icon(Icons.replay_10),
            //     onPressed: () {},
            //   ),
            // ],
            leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              //Menangani kejadian saat menu home diklik
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: dataAdminSave == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                      height: displayHeight(context) * 0.15,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                HexColor("#305a84"),
                                HexColor("#97c7eb")
                              ]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(160, 65),
                            bottomRight: Radius.elliptical(160, 65),
                          )),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Savings",
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ))),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataAdminSave.data.length,
                      itemBuilder: (context, i) {
                        // var data = dataAdminSave.deposit[i];
                        var barang = dataAdminSave.data[i];

                        // var total = data.createdAt;
                        // var total2 = data.tanggalLahir;

                        // var tanggalgabung =
                        //     DateFormat('dd-MM-yyyy').format(total);
                        // var tanggallahir =
                        //     DateFormat('dd-MM-yyyy').format(total2);
                        return Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              ExpansionTileCard(
                                leading: CircleAvatar(
                                    child: Icon(Icons.attach_money)),
                                title: Text(
                                    '${currencyFormatter.format(barang.total)}'),
                                // subtitle: Text('Status: Accepted'),
                                children: <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ));
  }
}
