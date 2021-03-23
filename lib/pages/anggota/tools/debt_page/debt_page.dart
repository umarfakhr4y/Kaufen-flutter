import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/model/profilemodel.dart';
import 'package:end_project/pages/admin/tools/viewModel/memberlistViewmodel.dart';
import 'package:end_project/pages/anggota/profilePage/botNavBar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '';

import '../../../../size_helper.dart';
import 'Data_model.dart';
import 'action/add_debt.dart';
import 'action/debt_viewmodel.dart';

class DebtPageMember extends StatefulWidget {
  @override
  DebtPageMemberState createState() => DebtPageMemberState();
}

class DebtPageMemberState extends State<DebtPageMember> {
  TextEditingController editingController = TextEditingController();
  // final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');
  final currencyFormatter = new NumberFormat.currency(locale: 'ID');
  TextEditingController pay = TextEditingController();
  var _loading = false;

  void initState() {
    super.initState();
    getNameNya();
  }

  DataLogin dataLogin;
  List dataMemberSingle;

  int user_id;
  int dataIdd;
  String namenya;

  void getNameNya() {
    getName().then((value) {
      setState(() {
        dataLogin = value;
        user_id = dataLogin.success.id;
        dataIdd = dataLogin.success.data[0].id;
        namenya = dataLogin.success.name;
        dataNya();
        // print(user_id);
        // print(dataIdd);
        // print(namenya);
        // dataNya();
      });
    });
  }

  void dataNya() {
    getSingleMemberUser(namenya).then((value) {
      setState(() {
        dataMemberSingle = value;
        print(dataMemberSingle);
        // print(dataMemberSingle[0].tanggal_Lahir);
      });
    });
  }

  void debtDelete(id) {
    deleteDebt(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success Canceling Debt Request",
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
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Failed Canceling Debt Request",
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
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddDebt(data_id: user_id, user_id: dataIdd);
                  }));
                },
              )
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
        body: dataMemberSingle == null
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
                            "My Submitted Debt",
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ))),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataMemberSingle[0].loans.length,
                      itemBuilder: (context, i) {
                        // var data = dataMemberSingle.loans[i];
                        var barang = dataMemberSingle[0].loans;

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
                              if (barang[i].waitingConfirmation == null)
                                ExpansionTileCard(
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.attach_money)),
                                  title: Text(
                                      '${currencyFormatter.format(barang[i].total)}'),
                                  subtitle: Text('Status: Unaccepted'),
                                  children: <Widget>[
                                    Divider(
                                      thickness: 1.0,
                                      height: 1.0,
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      buttonHeight: 52.0,
                                      buttonMinWidth: 90.0,
                                      children: <Widget>[
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () {
                                            debtDelete(barang[i].id);
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                              ),
                                              Text('Cancel Request',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              else if (barang[i].waitingConfirmation ==
                                  "accepted")
                                ExpansionTileCard(
                                  leading: CircleAvatar(
                                      child: Icon(Icons.attach_money)),
                                  title: Text(
                                      '${currencyFormatter.format(barang[i].total)}'),
                                  subtitle: Text('Status: Accepted'),
                                  children: <Widget>[
                                    Divider(
                                      thickness: 1.0,
                                      height: 1.0,
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      buttonHeight: 52.0,
                                      buttonMinWidth: 90.0,
                                      children: <Widget>[
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          onPressed: () {
                                            Alert(
                                                context: context,
                                                title: "Pay Debt",
                                                content: Column(
                                                  children: <Widget>[
                                                    TextField(
                                                      controller: pay,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: Icon(
                                                            Icons.attach_money),
                                                        labelText: 'Nominal ${currencyFormatter.format(barang[i].total)}',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                buttons: [
                                                  DialogButton(
                                                    onPressed: () {
                                                      if (int.parse(pay.text) >
                                                          barang[i].total) {
                                                        Alert(
                                                          context: context,
                                                          type: AlertType.error,
                                                          title: "Failed",
                                                          desc:
                                                              "You Must Enter Same Ammount Of your Debt",
                                                          buttons: [
                                                            DialogButton(
                                                              child: Text(
                                                                "Ok",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              width: 120,
                                                            )
                                                          ],
                                                        ).show();
                                                      } else {
                                                        decreasingDebt(
                                                            barang[i].total,
                                                            barang[i].id);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Pay",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  )
                                                ]).show();
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.attach_money,
                                                color: Colors.blue,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                              ),
                                              Text('Pay Debt',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
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
