import 'package:end_project/pages/admin/tools/debt_page/addDebt.dart';
import 'package:end_project/pages/admin/tools/debt_page/model/AcceptedDebt.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../size_helper.dart';
import '../debt_view_model.dart';
import '../model/debtList.dart';
import 'package:intl/intl.dart' as intl;

class AcceptedDebtList extends StatefulWidget {
  @override
  AcceptedDebtListState createState() => AcceptedDebtListState();
}

class AcceptedDebtListState extends State<AcceptedDebtList> {
  AcceptedDebt dataAccDebt;

  // final _formKey = GlobalKey<FormState>();

  void getAccDebt() {
    getListAcceptedDebt().then((value) {
      setState(() {
        dataAccDebt = value;
      });
    });
  }

  void initState() {
    super.initState();
    getAccDebt();
  }

  final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: KoperasiKeys._scaffoldKey,
      body: dataAccDebt == null
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
          : Column(
              children: [
                Container(
                    height: displayHeight(context) * 0.15,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
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
                          "Accepted Debt List",
                          style: TextStyle(
                              fontSize: displayHeight(context) * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ))),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataAccDebt.data.length,
                    itemBuilder: (context, i) {
                      var total = dataAccDebt.data[i].createdAt;
                      var re = DateFormat('dd-MM-yyyy').format(total);
                      var totaldua = dataAccDebt.data[i].datumReturn;
                      var redua = DateFormat('dd-MM-yyyy').format(totaldua);

                      return Column(
                        children: [
                          SizedBox(
                            height: displayHeight(context) * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.lightBlue[100],
                                    color: Colors.blueGrey[200],
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                child: ExpansionTileCard(
                                  title: Text(currencyFormatter
                                      .format(dataAccDebt.data[i].total)),
                                  subtitle: Text(
                                      'Debtor ${dataAccDebt.data[i].name}'),
                                  children: <Widget>[
                                    Divider(
                                      thickness: 1.0,
                                      height: 1.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0,
                                            vertical: 3.0,
                                          ),
                                          child: Column(
                                            children: [
                                              // if (dataAccDebt.data[i]
                                              //         .waitingConfirmation ==
                                              //     null)
                                              //   ListTile(
                                              //     title: Text("Paid"),
                                              //     subtitle: Text("Has not"),
                                              //   )
                                              // else
                                              //   new ListTile(
                                              //     title: Text("Paid"),
                                              //     subtitle: Text("Has Paid"),
                                              //   ),
                                              ListTile(
                                                title: Text("Accepted Debt on"),
                                                subtitle: Text(re),
                                              ),
                                              ListTile(
                                                title: Text("Return Debt on"),
                                                subtitle: Text(redua),
                                              )
                                            ],
                                          )),
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
            ),
    );
  }
}
