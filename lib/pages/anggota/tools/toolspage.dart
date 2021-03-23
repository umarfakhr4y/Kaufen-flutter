import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../size_helper.dart';
import 'debt_page/debt_page.dart';
import 'savings_page/savings_page.dart';

class ToolsPageAnggota extends StatefulWidget {
  @override
  _ToolsPageAnggotaState createState() => _ToolsPageAnggotaState();
}

class _ToolsPageAnggotaState extends State<ToolsPageAnggota> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                    "Tools",
                    style: TextStyle(
                        fontSize: displayHeight(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ))),
          SizedBox(
            height: displayHeight(context) * 0.03,
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: displayHeight(context) * 0.01,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.2,
                          width: displayHeight(context) * 0.2,
                          child: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: displayHeight(context) * 0.25,
                              width: displayHeight(context) * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DebtPageMember();
                                    
                                  }));
                                },
                                child: new Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            HexColor("#305a84"),
                                            HexColor("#97c7eb")
                                          ]),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Icon(
                                          Icons.money,
                                          color: Colors.white,
                                          size: displayHeight(context) * 0.08,
                                        ),
                                      ),
                                      Text("Debt",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: displayHeight(context) *
                                                  0.025)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: displayHeight(context) * 0.03,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.2,
                          width: displayHeight(context) * 0.2,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SavingListMember();
                                    
                                  }));
                              },
                              child: new Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          HexColor("#305a84"),
                                          HexColor("#97c7eb")
                                        ]),
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        Icons.attach_money,
                                        color: Colors.white,
                                        size: displayHeight(context) * 0.08,
                                      ),
                                    ),
                                    Text("Savings",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: displayHeight(context) *
                                                0.025)),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
