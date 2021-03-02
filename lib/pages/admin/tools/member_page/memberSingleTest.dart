import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addBarang.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addDeposit.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addLoan.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:end_project/pages/admin/tools/viewModel/memberlistViewmodel.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';

// import './viewModel/memberlistViewmodel.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MemberSingleTest extends StatefulWidget {
  @override
  MemberSingleTestState createState() => MemberSingleTestState();
}

class MemberSingleTestState extends State<MemberSingleTest>
    with SingleTickerProviderStateMixin {
  List dataMemberSingle;
  int _currentItem = 0;

  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  void getMember() {
    GetSingleTest().getSingleMemberUserTest().then((value) {
      setState(() {
        dataMemberSingle = value;
      });
    });
  }

  void initState() {
    super.initState();
    getMember();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          shadowColor: HexColor("#305a84"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              //Menangani kejadian saat menu home diklik
              onPressed: () {
                Navigator.pop(context);
              }),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Profile",
              ),
              Tab(
                text: "Loans",
              ),
            ],
          ),
        ),
        body: dataMemberSingle == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              )
            : TabBarView(
                children: [
                  ListView.builder(
                    itemCount: dataMemberSingle.length,
                    itemBuilder: (context, i) {
                      var data = dataMemberSingle;
                      // String tgljoin_mentah = data.createdAt.toString();
                      // var tglJoin = tgljoin_mentah.substring(0, 10);
                      return Column(
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
                                    data[i].name,
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ))),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: displayHeight(context) * 0.8,
                                height: displayHeight(context) * 0.6,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          HexColor("#305a84"),
                                          HexColor("#97c7eb")
                                        ]),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ListTile(
                                    //   title: Text(
                                    //     'Bergabung Sejak',
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    //   subtitle: Text(
                                    //     tglJoin,
                                    //     style: TextStyle(color: Colors.grey),
                                    //   ),
                                    // ),
                                    ListTile(
                                      title: Text(
                                        'Alamat',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        data[i].alamat,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Nomor Telepon',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        data[i].noTelp.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Tanggal Lahir',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        data[i].tanggalLahir.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  ////////////////////////////////
                  ////////////////////////////////

                  Scaffold(
                    body: dataMemberSingle == null
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataMemberSingle[0].loans.length,
                            itemBuilder: (context, i) {
                              print(dataMemberSingle[0].loans.name.toString());
                              return Center(
                                child: Text("asd"),
                              );
                              // return dataMemberSingle[i].loans.length <= 0
                              //     ? Center(child: Text("Tidak Ada Barang"))
                              //     : Column(
                              //         children: [
                              //           SizedBox(
                              //             height: displayHeight(context) * 0.02,
                              //           ),
                              //           Align(
                              //             alignment: Alignment.center,
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Container(
                              //                 width:
                              //                     displayHeight(context) * 0.8,
                              //                 height:
                              //                     displayHeight(context) * 0.25,
                              //                 decoration: BoxDecoration(
                              //                     gradient: LinearGradient(
                              //                         begin:
                              //                             Alignment.centerLeft,
                              //                         end:
                              //                             Alignment.centerRight,
                              //                         colors: [
                              //                           HexColor("#305a84"),
                              //                           HexColor("#97c7eb")
                              //                         ]),
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10)),
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           EdgeInsets.fromLTRB(
                              //                               10, 10, 10, 0),
                              //                       child: Align(
                              //                         alignment:
                              //                             Alignment.topRight,
                              //                       ),
                              //                     ),
                              //                     ListTile(
                              //                       title: Text(
                              //                         'Nama peminjam',
                              //                         style: TextStyle(
                              //                             color: Colors.white),
                              //                       ),
                              //                       subtitle: Text(
                              //                           "dataMemberSingle[i].loans.name"),
                              //                     ),
                              //                     // ListTile(
                              //                     //   title: Text(
                              //                     //     'Jumlah yang Dipinjam', style: TextStyle(color: Colors.white),
                              //                     //   ),
                              //                     //   subtitle: Text(barang[i]
                              //                     //       .total
                              //                     //       .toString()),
                              //                     // ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           )
                              //         ],
                              //       );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
//other product itu barang dari titipan si yg ada di memver list
