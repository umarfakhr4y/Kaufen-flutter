import 'dart:ui';

import 'package:end_project/pages/admin/tools/viewModel/productViewModel.dart';
import 'package:end_project/pages/penjual/tools/transaksi/allProduct/ProductKoperasi_detail.dart';
import 'package:end_project/pages/penjual/tools/transaksi/allProduct/product_model/titipan_penjual.dart';
import 'package:end_project/pages/penjual/tools/transaksi/allProduct/product_viewmodel/product_list.dart';
import 'package:shimmer/shimmer.dart';
import './product_model/koperasi_penjual.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:hexcolor/hexcolor.dart';

import 'ProductTitipan_detail.dart';

class Product extends StatefulWidget {
  @override
  ProductState createState() => ProductState();
}

class ProductState extends State<Product> {
  KoperasiPenjual dataKoperasi;
  TitipanPenjual dataTitipan;

  void getKoperasiProduct() {
    KoperasiGetpenjual().getProduct().then((value) {
      setState(() {
        dataKoperasi = value;
      });
    });
  }

  void getTitipanProduct() {
    TitipanGetpenjual().getProduct().then((value) {
      setState(() {
        dataTitipan = value;
      });
    });
  }

  void initState() {
    super.initState();
    getKoperasiProduct();
    getTitipanProduct();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          shadowColor: Colors.lightBlue[200],
          leading: new Container(),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Barang Koperasi",
              ),
              Tab(
                text: "Barang Titipan",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
                body: dataKoperasi == null
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
                                fontSize: displayHeight(context) * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
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
                                    "Barang Koperasi",
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))),
                          Expanded(
                            child: ListView.builder(
                                itemCount: dataKoperasi.data.length,
                                itemBuilder: (context, i) {
                                  var col = dataKoperasi.data[i];
                                  print(dataKoperasi.data[i].image);
                                  return Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('${col.name}'),
                                            trailing: Icon(Icons.arrow_right),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductkoperasiScreen(
                                                          nameBarang: col.name,
                                                          image: col.image,
                                                          stock: int.parse(
                                                              col.stock),
                                                          id: col.id,
                                                          harga: col.harga
                                                              .toString(),
                                                        )),
                                              );
                                            },
                                          )));
                                }),
                          )
                        ],
                      )),

            /////////////////////////////////
            /////////////////////////////////
            Scaffold(
                body: dataTitipan == null
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
                                fontSize: displayHeight(context) * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
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
                                    "Barang Titipan",
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))),
                          Expanded(
                            child: ListView.builder(
                                itemCount: dataTitipan.data.length,
                                itemBuilder: (context, i) {
                                  var col = dataTitipan.data[i];
                                  return Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                          elevation: 5,
                                          child: ListTile(
                                            title: Text('${col.nameBarang}'),
                                            trailing: Icon(Icons.arrow_right),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProducttitipanScreen(
                                                          nameBarang:
                                                              col.nameBarang,
                                                          image: col.image,
                                                          stock: col.stock,
                                                          id: col.id,
                                                          harga: col.harga
                                                              .toString(),
                                                        )),
                                              );
                                            },
                                          )));
                                }),
                          )
                        ],
                      )),
            ///////////////////////
            ///////////////////////
          ],
        ),
      ),
    );
  }
}
