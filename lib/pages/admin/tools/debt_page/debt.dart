import 'dart:ui';

import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/debt_page/addDebt.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../../size_helper.dart';
import 'accepted_debt/acceptedDebt.dart';
import 'debt_view_model.dart';
import 'model/debtList.dart';
import 'package:intl/intl.dart' as intl;

class DebtList extends StatefulWidget {
  @override
  DebtListState createState() => DebtListState();
}

class DebtListState extends State<DebtList> {
  List dataDebt;

  // final _formKey = GlobalKey<FormState>();

  void getDebt() {
    getListDebt().then((value) {
      setState(() {
        dataDebt = value;
      });
    });
  }

  void initState() {
    super.initState();
    getDebt();
  }

  void debtAccept(id) {
    acceptDebt(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success in Adding Debt",
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
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Failed to Add Debt",
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

  final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Kaufen"),
              actions: [
                
                // IconButton(
                //   icon: Icon(Icons.add),
                //   color: Colors.white,
                //   onPressed: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                //       return AddDebt();
                //     }));
                //   },
                // ),
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
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Request",
                  ),
                  Tab(
                    text: "Pay",
                  ),
                ],
              ),
            ),

            // key: KoperasiKeys._scaffoldKey,
            body: dataDebt == null
                ? Center(
                    child: SizedBox(
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey,
                        child: Text(
                          'Loading',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: displayHeight(context) * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                : TabBarView(
                    children: [
                      Scaffold(
                          body: dataDebt == null
                              ? Center(
                                  child: SizedBox(
                                    // width: 200.0,
                                    // height: 100.0,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.white,
                                      highlightColor: Colors.grey,
                                      child: Text(
                                        'Loading',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              displayHeight(context) * 0.05,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                              bottomLeft:
                                                  Radius.elliptical(160, 65),
                                              bottomRight:
                                                  Radius.elliptical(160, 65),
                                            )),
                                        child: Center(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Request Debt List",
                                              style: TextStyle(
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.05,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ))),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: dataDebt.length,
                                        itemBuilder: (context, i) {
                                          var total = dataDebt[i].createdAt;
                                          var re = DateFormat('dd-MM-yyyy')
                                              .format(total);

                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 10, 0),
                                                child: GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 2, 2, 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        // color: Colors.lightBlue[100],
                                                        color: Colors
                                                            .blueGrey[200],
                                                        border: Border.all(
                                                            width: 2,
                                                            color:
                                                                Colors.white)),
                                                    child: ExpansionTileCard(
                                                      // title: Text("asd"),
                                                      title: Text(
                                                          currencyFormatter
                                                              .format(
                                                                  dataDebt[i]
                                                                      .total)),
                                                      subtitle: Text(
                                                          'Debtor ${dataDebt[i].name}'),
                                                      children: <Widget>[
                                                        Divider(
                                                          thickness: 1.0,
                                                          height: 1.0,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 3.0,
                                                                vertical: 3.0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  ListTile(
                                                                    title: Text(
                                                                        "Debt Return Date"),
                                                                    subtitle:
                                                                        Text(
                                                                            re),
                                                                  )
                                                                ],
                                                              )),
                                                        ),
                                                        ButtonBar(
                                                          alignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          buttonHeight: 52.0,
                                                          buttonMinWidth: 90.0,
                                                          children: <Widget>[
                                                            FlatButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0)),
                                                              onPressed: () {
                                                                debtAccept(
                                                                    dataDebt[i]
                                                                        .id);
                                                              },
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                  ),
                                                                  Text(
                                                                    'Accept',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            FlatButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0)),
                                                              onPressed: () {},
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                  ),
                                                                  Text('Remove',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {},
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),

                      /////////////////////////////////
                      /////////////////////////////////
                      Scaffold(
                          body: AcceptedDebtList())
                    ],
                  )
            ));
  }
}
