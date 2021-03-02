import 'dart:ui';

import 'package:end_project/pages/penjual/profilePage/botNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'product_viewmodel/product_list.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../size_helper.dart';

typedef void CountButtonClickCallBack(int count);

class ProducttitipanScreen extends StatefulWidget {
  final String nameBarang;
  final String harga;
  final int stock;
  final String image;

  final int id;
  final int initialCount;
  final CountButtonClickCallBack onChange;
  // final String desc;

  ProducttitipanScreen(
      {this.nameBarang,
      this.harga,
      this.initialCount,
      this.onChange,
      this.stock,
      this.id,
      this.image});
  @override
  _ProducttitipanScreenState createState() => _ProducttitipanScreenState();
}

class _ProducttitipanScreenState extends State<ProducttitipanScreen> {
//  final String title;

  final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');
  int count = 1;
  var _loading = false;

  @override
  void initState() {
    super.initState();
    count = 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCount(int addValue) {
    if (count + addValue >= 0) {
      setState(() {
        count += addValue;
      });
      if (widget.onChange != null) {
        widget.onChange(count);
      }
    }
  }

  void decreasingpenjualValue(int id) {
    setState(() {
      _loading = true;
    });
    editPenjualProduct(count, widget.stock, widget.id).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success Editing data",
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PenjualPage()),
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
            desc: "Failed Editing Data",
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
      // appBar: AppBar(title: Text(loadedProduct.title),),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: displayHeight(context) * 0.36,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                  // width: displayHeight(context) * 0.1,
                  // height: displayHeight(context) * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(widget.nameBarang),
                  )),
              background: Hero(
                tag: 1,
                child: Image.network(
                  'http://coperationv2.herokuapp.com/img/${widget.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                          height: displayHeight(context) * 0.07,
                          width: displayHeight(context) * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              )),
                          child: Center(
                            child: Text(
                              currencyFormatter.format(int.parse(widget.harga)),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Container(
                          height: displayHeight(context) * 0.04,
                          width: displayHeight(context) * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              )),
                          child: Center(
                            child: Text(
                              'Stock: ${widget.stock}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "",
                    textAlign: TextAlign.center,
                    softWrap: true,
                  )),
              Container(
                height: displayHeight(context) * 0.4,
                child: ListView(children: <Widget>[]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: displayHeight(context) * 0.07,
                      child: Container(
                          decoration:
                              BoxDecoration(color: HexColor("#e3e3e3e3")),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text("Total Rp 1.000.000",
                                      //     style: TextStyle(
                                      //         color: Colors.grey,
                                      //         fontSize: displayHeight(context) *
                                      //             0.025)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Card(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          updateCount(-1);
                                                        },
                                                        child: Container(
                                                            width: 50.0,
                                                            child: Center(
                                                                child: Text(
                                                              '-  ',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      25.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            )))),
                                                    Container(
                                                      child: Center(
                                                          child: Text(
                                                        '$count',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.blue,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      )),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          updateCount(1);
                                                        },
                                                        child: Container(
                                                            width: 50.0,
                                                            child: Center(
                                                                child: Text(
                                                              '  +',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      25.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            )))),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        if (count > widget.stock) {
                                          Alert(
                                            context: context,
                                            type: AlertType.warning,
                                            title: "insufficient stock",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                width: 120,
                                              )
                                            ],
                                          ).show();
                                        } else {
                                          decreasingpenjualValue(widget.id);
                                        }

                                        // print(count);
                                      },
                                      child: SizedBox(
                                        height: displayHeight(context) * 0.07,
                                        width: displayHeight(context) * 0.18,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    HexColor("#305a84"),
                                                    HexColor("#97c7eb")
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              )),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    0.016,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    if (_loading)
                                                      Text("Proccesing",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  displayHeight(
                                                                          context) *
                                                                      0.03))
                                                    else
                                                      Text("Buy",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  displayHeight(
                                                                          context) *
                                                                      0.03))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ), //last one
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
