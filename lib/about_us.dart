import 'dart:ui';

import 'package:end_project/pages/admin/tools/member_page/getdataMember.dart';
import 'package:end_project/welcome.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  void initState() {
    super.initState();
  }

  // getDataname(dataLogin.success.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#e3e3e3"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: displayHeight(context) * 0.4,
                decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage('assets/aboutus.png'),
                      fit: BoxFit.cover,
                    ),
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
                    Container(
                      height: displayHeight(context) * 0.25,
                      width: displayHeight(context) * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Colors.lightBlue[100],
                        image: new DecorationImage(
                          image: new ExactAssetImage('assets/app/icon_trs.png'),
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(
                      'Kaufen',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: displayHeight(context) * 0.04),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ExpansionTileCard(
                      title: Text("Keunggulan"),
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
                                  ListTile(
                                      title: Text(
                                        '1. Design yang menarik',
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                            "dalam segi tampilan, kami kaufen developers menyediakan produk yang mempunyai tampilan berkualitas dan menarik"),
                                      )),
                                  ListTile(
                                    title: Text(
                                      '2. Mudah untuk digunakan',
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                          'tidak hanya mempunyai tampilan yang menarik, kaufen pun menyediakan tampilan yang mudah digunakan untuk para user dan nyaman di mata para user sekalian'),
                                    ),
                                  ),
                                  ListTile(
                                      title: Text(
                                        '3. fitur lengkap',
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                            'untuk sebuah program, program kami (Kaufen) sudah memiliki fitur yang lengkap yang siap membantu kinerja organisasi yang memakai aplikasi kami'),
                                      )),
                                ],
                              )),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ExpansionTileCard(
                      title: Text("Visi dan Misi"),
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
                                  ListTile(
                                      title: Text(
                                        'Visi',
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                            "Menjadi Koperasi Simpan Pinjam yang sehat dan terpercaya serta memberikan solusi keuangan bagi anggota."),
                                      )),
                                  ListTile(
                                      title: Text(
                                        'Misi',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Meningkatkan profesionalisme pengelola koperasi (Admin, Penjual, dan Anggota)"),
                                              SizedBox(
                                                height: displayHeight(context) * 0.01,
                                              ),
                                              Text(
                                                  "Mengoptimalkan sumber daya yang ada untuk meningkatkan pelayanan dan usaha koperasi"),
                                            ],
                                          ))),
                                ],
                              )),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ExpansionTileCard(
                      title: Text("Kelompok 5"),
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
                                  ListTile(
                                      title: Text(
                                        'Ketua',
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text("Damar Ardian"),
                                      )),
                                  ListTile(
                                      title: Text(
                                        'Flutter Developer',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Umar Fakhry"),
                                              Text("Hanif Fadhlurrahman")
                                            ],
                                          ))),
                                  ListTile(
                                      title: Text(
                                        'Web Developer',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Ibrahim Ahmad"),
                                              Text("Hasan Munif")
                                            ],
                                          ))),
                                  ListTile(
                                      title: Text(
                                        'Back end Developer',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Damar Ardian"),
                                              Text("Akmal Ilham")
                                            ],
                                          ))),
                                          ListTile(
                                      title: Text(
                                        'Back end Developer',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Damar Ardian"),
                                              Text("Akmal Ilham")
                                            ],
                                          ))),
                                          ListTile(
                                      title: Text(
                                        'Server',
                                      ),
                                      subtitle: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Farhan Khosyi"),
                                              Text("Erlangga Dwi"),
                                              
                                            ],
                                          ))),
                                ],
                              )),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
