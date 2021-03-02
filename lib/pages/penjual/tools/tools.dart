import 'package:end_project/pages/penjual/tools/transaksi/allProduct/Product.dart';
import 'package:end_project/pages/penjual/tools/transaksi/cashier.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class PenjualToolsPage extends StatefulWidget {
  @override
  _PenjualToolsPageState createState() => _PenjualToolsPageState();
}

class _PenjualToolsPageState extends State<PenjualToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: displayHeight(context) * 0.01,
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
                          height: displayHeight(context) * 0.25,
                          width: displayHeight(context) * 0.2,
                          child: GestureDetector(
                              onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Product()),
                                  );
                                },
                              child: new Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.lightBlue[100],
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/uang.png'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black, BlendMode.hue),
                                    ),
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
                                        Icons.monetization_on,
                                        color: Colors.white,
                                        size: displayHeight(context) * 0.11,
                                      ),
                                    ),
                                    Text("Transaksi",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: displayHeight(context) *
                                                0.03)),
                                  ],
                                ),
                              )),
                        ),
                        
                      ],
                    )
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
