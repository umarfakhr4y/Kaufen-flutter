import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import 'profile.dart';
import '../tools/tools.dart';
import '../home/home.dart';
import '../../../auth/auth.dart';
import './model/profilemodel.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

var tstyle = TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 50);

class _AdminPageState extends State<AdminPage> {
  DataLogin dataLogin;
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  PageController controller = PageController();

  int _index = 0;
  List<Color> colors = [
    Colors.lightBlue[200],
    Colors.lightBlue[200],
    Colors.lightBlue[200],
  ];

  void getDataLogin() {
    UserViewModel().getUser().then((value) {
      setState(() {
        dataLogin = value;
      });
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[HomeAdmin(), ToolsPage(), ProfileAdmin()];

    return Scaffold(
      extendBody: true,
      body: PageView.builder(
          itemCount: 3,
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              _index = page;
            });
          },
          itemBuilder: (context, position) {
            return Container(
              color: colors[position],
              child: Center(child: _listPage[position]),
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: HexColor("#305a84"),
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 25),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            child: GNav(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: gap,
                  icon: Icons.home,
                  iconColor: Colors.black,
                  iconActiveColor: HexColor("#305a84"),
                  text: 'Home',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.settings,
                  iconColor: Colors.black,
                  iconActiveColor: HexColor("#305a84"),
                  text: 'Tools',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 24,
                  padding: padding,
                ),
                GButton(
                  gap: gap,
                  icon: Icons.account_circle,
                  iconColor: Colors.black,
                  iconActiveColor: HexColor("#305a84"),
                  text: 'Profile',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 24,
                  padding: padding,
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
