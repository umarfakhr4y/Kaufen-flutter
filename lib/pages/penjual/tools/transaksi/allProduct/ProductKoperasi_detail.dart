import 'dart:ui';

import 'package:end_project/pages/penjual/profilePage/botNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'product_viewmodel/product_list.dart';
import 'package:intl/intl.dart' as intl;
import 'counter.dart';

import '../../../../../size_helper.dart';

typedef void CountButtonClickCallBack(int count);

class ProductkoperasiScreen extends StatefulWidget {
  final String nameBarang;
  final String harga;
  final String image;
  final int stock;
  final int id;
  final int initialCount;
  final CountButtonClickCallBack onChange;
  // final String desc;

  ProductkoperasiScreen(
      {this.nameBarang,
      this.harga,
      this.initialCount,
      this.onChange,
      this.stock,
      this.id,
      this.image});
  @override
  _ProductkoperasiScreenState createState() => _ProductkoperasiScreenState();
}

class _ProductkoperasiScreenState extends State<ProductkoperasiScreen> {
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

  void decreasingkoperasiValue(int id) {
    setState(() {
      _loading = true;
    });
    editKoperasiProduct(_count, widget.stock, widget.id).then((value) {
      setState(() {
        if (value == true) {
          setState(() {
            _loading = false;
          });
          Alert(
            context: context,
            type: AlertType.success,
            title: "Success",
            desc: "Success Buying ${widget.nameBarang}",
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
            desc: "Failed Buying ${widget.nameBarang}",
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

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: '1',
                        child: Image.network(
                          "http://coperationv2.herokuapp.com/img/${widget.image}",
                          width: MediaQuery.of(context).size.width * .7,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.nameBarang,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        
                      ],
                    ),
                    Text(
                      "Stock : ${widget.stock}",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (_count <= 0) {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "Warning",
                                desc: "Value Cannot Under 0",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            } else {
                              setState(() {
                                _count -= 1;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        Text("$_count"),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () {
                            if (_count >= widget.stock) {
                              Alert(
                                context: context,
                                title: "Warning",
                                type: AlertType.warning,
                                desc:
                                    "Maximum Input for ${widget.nameBarang} is ${widget.stock}",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            } else {
                              setState(() {
                                _count += 1;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: displayHeight(context) * 0.2),
                        Text(
                          currencyFormatter.format(int.parse(widget.harga)),
                          style: TextStyle(fontSize: displayHeight(context) * 0.02),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: displayHeight(context) * 0.06,
                      child: RaisedButton(
                        child: Text(
                          "Buy",
                          style: Theme.of(context).textTheme.button.apply(
                                color: Colors.white,
                              ),
                        ),
                        onPressed: () {
                          print(_count);
                          if (_count == 0) {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Warning",
                              desc: "Value Cannot Be 0",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          } else {
                            decreasingkoperasiValue(widget.id);
                          }
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
