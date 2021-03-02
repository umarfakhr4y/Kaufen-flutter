import 'dart:convert';
import 'dart:ui';

import 'package:end_project/pages/penjual/home/view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:json_table/json_table.dart';
import 'package:shimmer/shimmer.dart';

import 'package:hexcolor/hexcolor.dart';
import '../../chart/data/data.dart';
import '../../chart/titles/bar_titles.dart';
import '../../chart/titles/line_titles.dart';


import '../../history_home/model/pinjamanModel.dart';
import '../../history_home/model/tabunganModel.dart';

class HomePenjual extends StatefulWidget {
  @override
  _HomePenjualState createState() => _HomePenjualState();
}

class _HomePenjualState extends State<HomePenjual> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPinjaman();
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
        body: dataPinjaman == null
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
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                height: displayHeight(context) * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: displayHeight(context) * 0.23,
                                    height: displayHeight(context) * 0.25,
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
                                             :JsonTable(inijson,
                                                columns: columns)
                                             )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: displayHeight(context) * 0.02,
                                  ),
                                  Container(
                                    width: displayHeight(context) * 0.23,
                                    height: displayHeight(context) * 0.25,

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
                                            ? Center(child: Text("Tidak ada Data"),)
                                             :JsonTable(inijsonjuga,
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
