import 'dart:convert';
import 'dart:ui';

import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/model/profilemodel.dart';
import 'package:end_project/pages/admin/tools/member_page/getdataMember.dart';
import 'package:end_project/pages/penjual/home/view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:json_table/json_table.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

import 'package:hexcolor/hexcolor.dart';
import '../../chart/data/data.dart';
import '../../chart/titles/bar_titles.dart';
import '../../chart/titles/line_titles.dart';

import '../../history_home/model/pinjamanModel.dart';
import '../../history_home/model/tabunganModel.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPinjaman();
    getDataLogin();
    // getTabungan();
    columns = [
      JsonTableColumn("total", label: "Daftar Hutang (RP)"),
    ];
    columnsdua = [
      JsonTableColumn("total", label: "Daftar Tabungan (RP)"),
    ];
  }

  final double barWidth = 22;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  Pinjaman dataPinjaman;
  Tabungan datatabungan;
  String jsonPertama;
  String jsonkedua;
  DataLogin dataLogin;

  void getPinjaman() {
    GETpinjaman().getProduct().then((value) {
      setState(() {
        dataPinjaman = value;

        jsonPertama = json.encode(dataPinjaman.data).toString();
      });
    });
    GETtabungan().getProduct().then((value) {
      setState(() {
        datatabungan = value;
        jsonkedua = json.encode(datatabungan.data).toString();
      });
    });
  }

  _onAlertWithStylePressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 300),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.topCenter);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "Warning",
      desc: "Please Complete Your Profile",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetDatamember(
                        nameoper: dataLogin.success.name,
                        userid_oper: dataLogin.success.id,
                      )),
            );
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  void getDataLogin() {
    UserViewModel().getUser().then((value) {
      setState(() {
        dataLogin = value;
        if (dataLogin.success.data.length <= 0) {
          _onAlertWithStylePressed(context);
          // Alert(
          //   context: context,
          //   type: AlertType.warning,
          //   title: "Warning",
          //   desc: "Please Complete Your Profile",
          //   buttons: [
          //     DialogButton(
          //       child: Text(
          //         "Go",
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => GetDatamember(
          //                     nameoper: dataLogin.success.name,
          //                     userid_oper: dataLogin.success.id,
          //                   )),
          //         );
          //       },
          //       width: 120,
          //     )
          //   ],
          // ).show();
        }
      });
    });
  }

  bool toggle = true;
  List<JsonTableColumn> columns;
  List<JsonTableColumn> columnsdua;

  @override
  Widget build(BuildContext context) {
    var inijson = (jsonPertama != null) ? jsonDecode(jsonPertama) : null;
    var inijsonjuga = (jsonkedua != null) ? jsonDecode(jsonkedua) : null;

    return Scaffold(
        backgroundColor: HexColor("#e3e3e3"),
        appBar: AppBar(
          title: Text("Kaufen"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
          ),
          elevation: 0,
          shadowColor: Colors.lightBlue[200],
          leading: new Container(),
        ),
        body: dataPinjaman == null || datatabungan == null
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
                        fontSize: displayHeight(context) * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                        child: Column(children: [
                          Center(
                              child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Laporan Stock",
                                          style: TextStyle(
                                              fontSize:
                                                  displayHeight(context) * 0.02,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: displayHeight(context) * 0.03,
                                      ),
                                      Container(
                                          height: displayHeight(context) * 0.25,
                                          width: displayHeight(context) * 0.5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: BarChart(
                                            BarChartData(
                                              alignment:
                                                  BarChartAlignment.center,
                                              maxY: 20,
                                              groupsSpace:
                                                  displayHeight(context) *
                                                      0.026,
                                              barTouchData:
                                                  BarTouchData(enabled: true),
                                              titlesData: FlTitlesData(
                                                bottomTitles:
                                                    BarTitles.getBottomTitles(),
                                                leftTitles:
                                                    BarTitles.getLeftTitles(),
                                                rightTitles:
                                                    BarTitles.getRightTitles(),
                                              ),
                                              gridData: FlGridData(
                                                checkToShowHorizontalLine:
                                                    (value) =>
                                                        value %
                                                            BarData.interval ==
                                                        0,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                  if (value == 0) {
                                                    return FlLine(
                                                      color: const Color(
                                                          0xff363753),
                                                      strokeWidth: 3,
                                                    );
                                                  } else {
                                                    return FlLine(
                                                      color: const Color(
                                                          0xff2a2747),
                                                      strokeWidth: 0.8,
                                                    );
                                                  }
                                                },
                                              ),
                                              barGroups: BarData.barData
                                                  .map(
                                                    (data) => BarChartGroupData(
                                                      x: data.id,
                                                      barRods: [
                                                        BarChartRodData(
                                                          y: data.y,
                                                          width: barWidth,
                                                          colors: [data.color],
                                                          borderRadius:
                                                              data.y > 0
                                                                  ? BorderRadius
                                                                      .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              6),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              6),
                                                                    )
                                                                  : BorderRadius
                                                                      .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              6),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              6),
                                                                    ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          )),
                                    ],
                                  )),
                              SizedBox(
                                height: displayHeight(context) * 0.05,
                              ),
                              Container(
                                width: displayHeight(context) * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text("Laporan Keuangan",
                                        style: TextStyle(
                                            fontSize:
                                                displayHeight(context) * 0.02,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: displayHeight(context) * 0.03,
                                    ),
                                    Container(
                                      width: displayHeight(context) * 0.5,
                                      height: displayHeight(context) * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: LineChart(
                                        LineChartData(
                                          minX: 0,
                                          maxX: 11,
                                          minY: 0,
                                          maxY: 6,
                                          titlesData: LineTitles.getTitleData(),
                                          gridData: FlGridData(
                                            show: true,
                                            getDrawingHorizontalLine: (value) {
                                              return FlLine(
                                                color: const Color(0xff37434d),
                                                strokeWidth: 1,
                                              );
                                            },
                                            drawVerticalLine: true,
                                            getDrawingVerticalLine: (value) {
                                              return FlLine(
                                                color: const Color(0xff37434d),
                                                strokeWidth: 1,
                                              );
                                            },
                                          ),
                                          borderData: FlBorderData(
                                            show: true,
                                            border: Border.all(
                                                color: const Color(0xff37434d),
                                                width: 1),
                                          ),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: [
                                                FlSpot(0, 3),
                                                FlSpot(2.6, 2),
                                                FlSpot(4.9, 5),
                                                FlSpot(6.8, 2.5),
                                                FlSpot(8, 4),
                                                FlSpot(9.5, 3),
                                                FlSpot(11, 4),
                                              ],
                                              isCurved: true,
                                              colors: gradientColors,
                                              barWidth: 5,
                                              // dotData: FlDotData(show: false),
                                              belowBarData: BarAreaData(
                                                show: true,
                                                colors: gradientColors
                                                    .map((color) =>
                                                        color.withOpacity(0.3))
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: displayHeight(context) * 0.215,
                                    // height: displayHeight(context) * 0.25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text("Laporan Hutang",
                                            style: TextStyle(
                                                fontSize:
                                                    displayHeight(context) *
                                                        0.02,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: displayHeight(context) * 0.03,
                                        ),
                                        Container(
                                            // height: displayHeight(context) * 0.25,
                                            // width: displayHeight(context) * 0.5,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: jsonPertama == "[]"
                                                ? Text("Tidak ada Data")
                                                : JsonTable(inijson,
                                                    columns: columns))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: displayHeight(context) * 0.02,
                                  ),
                                  Container(
                                    width: displayHeight(context) * 0.215,
                                    // height: displayHeight(context) * 0.25,

                                    // height: displayHeight(context) * 0.25,

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text("Laporan Tabungan",
                                            style: TextStyle(
                                                fontSize:
                                                    displayHeight(context) *
                                                        0.02,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: displayHeight(context) * 0.03,
                                        ),
                                        Container(
                                            // height: displayHeight(context) * 0.25,
                                            width: displayHeight(context) * 0.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: jsonkedua == "[]"
                                                ? Center(
                                                    child:
                                                        Text("Tidak ada Data"),
                                                  )
                                                : JsonTable(inijsonjuga,
                                                    columns: columnsdua)

                                            // JsonTable(
                                            //   inijsonjuga,
                                            //   columns: columnsdua,
                                            // )
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(
                              //   height: displayHeight(context) * 0.05,
                              // ),

                              SizedBox(
                                height: displayHeight(context) * 0.05,
                              ),
                            ],
                          )),
                        ])),
                    SizedBox(
                      height: displayHeight(context) * 0.05,
                    ),
                  ],
                ),
              ));
  }
}
