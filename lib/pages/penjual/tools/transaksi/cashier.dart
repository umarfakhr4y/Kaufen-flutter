import 'dart:ui';

import 'package:end_project/pages/admin/tools/member_page/getdataMember.dart';
import 'package:end_project/pages/editProfile.dart';
import 'package:end_project/pages/change_pw/forgotPw.dart';
import 'package:end_project/welcome.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:shimmer/shimmer.dart';

import 'allProduct/Product.dart';

class Cashier extends StatefulWidget {
  @override
  CashierState createState() => CashierState();
}

class CashierState extends State<Cashier> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kaufen"),
        leading: BackButton(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
        ),
        elevation: 0,
        shadowColor: Colors.lightBlue[200],
      ),
      body: Column(
        children: [
          Container(
            height: displayHeight(context) * 0.1,
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
                  'Cashier',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: displayHeight(context) * 0.04),
                ),
              ],
            )),
          ),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Product()),
                  );
                },
                child: new Container(
                    decoration: new BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(displayHeight(context) * 0.1),
                    ),
                    child: Column(
                      children: [
                        Container(
                            height: displayHeight(context) * 0.3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: displayHeight(context) * 0.02,
                                  vertical: displayHeight(context) * 0.02),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.grey[400],
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const ListTile(
                                        title: Icon(
                                          Icons.add_circle_outline_rounded,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.center,
                                          child: Text('Add Product',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30)),
                                        )),
                                  ],
                                ),
                              ),
                            )),
                            
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
