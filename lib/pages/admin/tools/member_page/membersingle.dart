import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/botNavBar.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addBarang.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addDeposit.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/addLoan.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/editDeposit.dart';
import 'package:end_project/pages/admin/tools/member_page/single_action/editLoan.dart';
import 'package:end_project/pages/admin/tools/otherproduct_page/editOtherproduct.dart';
import 'package:end_project/pages/admin/tools/viewModel/memberSingleViewmodel.dart';
import 'package:end_project/pages/admin/tools/viewModel/memberlistViewmodel.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';

// import './viewModel/memberlistViewmodel.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MemberSingle extends StatefulWidget {
  @override
  final String name;
  final int id;
  MemberSingle({this.name, this.id});

  MemberSingleState createState() => MemberSingleState();
}

class MemberSingleState extends State<MemberSingle>
    with SingleTickerProviderStateMixin {
  List dataMemberSingle;
  final int asdqwe = 0;
  bool lunasges = true;

  final currencyFormatter = new NumberFormat.currency(locale: 'ID');
  int _currentItem = 0;

  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  void getMember() {
    getSingleMemberUser(widget.name).then((value) {
      setState(() {
        dataMemberSingle = value;
      });
    });
  }

  void vervicDelete(id) {
    setState(() {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Delete User",
        desc: "Are you sure want to delete selected user?",
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            width: 120,
          ),
          DialogButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              userDelete(id);
              // Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    });
  }

  void userDelete(id) {
    deleteUser(id).then((value) {
      if (value == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Failed Deleting User",
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
  }

  void depositDelete(id) {
    deleteDeposit(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success Deleting Deposit",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                  (Route<dynamic> route) => false,
                );
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Failed Deleting Deposit",
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
  }

  void loanDelete(id) {
    deleteLoan(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success Deleting Loans Data ",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                  (Route<dynamic> route) => false,
                );
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failed",
          desc: "Failed Deleting Loans Data ",
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
  }

  void productDeletedata(id) {
    deleteproductSingle(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Sucess",
          desc: "Sucess Deleting entrusted goods",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                  (Route<dynamic> route) => false,
                );
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Failde",
          desc: "Failde Deleting entrusted goods",
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
  }

  void initState() {
    super.initState();
    getMember();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.name} | Kaufen"),
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
              onPressed: () {
                vervicDelete(widget.id);
              },
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
              Tab(
                text: "Deposit",
              ),
              Tab(
                text: "Goods",
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                label: 'Loans',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddLoans(
                      nameoper: widget.name,
                      id: widget.id,
                    );
                  }));
                }),
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                label: 'Deposit',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddDeposit(
                      nameoper: widget.name,
                      id: widget.id,
                    );
                  }));
                }),
            SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                label: 'Goods',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddBarangs(
                      nameoper: widget.name,
                      id: widget.id,
                    );
                  }));
                }),
          ],
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
                      var data = dataMemberSingle[i];

                      var total = data.createdAt;
                      var total2 = data.tanggalLahir;

                      var tanggalgabung =
                          DateFormat('dd-MM-yyyy').format(total);
                      var tanggallahir =
                          DateFormat('dd-MM-yyyy').format(total2);
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
                                    data.name,
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
                                    ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.all(
                                          displayHeight(context) * 0.01,
                                        ),
                                        padding: EdgeInsets.all(
                                          displayHeight(context) * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Icon(
                                          Icons.swap_horizontal_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        'Joined Since',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        tanggalgabung,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.all(
                                          displayHeight(context) * 0.01,
                                        ),
                                        padding: EdgeInsets.all(
                                          displayHeight(context) * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        'Address',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        data.alamat,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.all(
                                          displayHeight(context) * 0.01,
                                        ),
                                        padding: EdgeInsets.all(
                                          displayHeight(context) * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        'Phone number',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        data.noTelp,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.all(
                                          displayHeight(context) * 0.01,
                                        ),
                                        padding: EdgeInsets.all(
                                          displayHeight(context) * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        'Date of birth',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        tanggallahir,
                                        style: TextStyle(color: Colors.white),
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
                    body: dataMemberSingle[0].loans.length == ""
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataMemberSingle[0].loans.length,
                            itemBuilder: (context, i) {
                              List<int> nomor = [1, 2, 3, 4];
                              var format = new DateFormat("dd:mm:yyyy");
                              var barang = dataMemberSingle[0].loans;
                              var total = barang[i].loanReturn;
                              var nodata =
                                  asdqwe + dataMemberSingle[0].loans.length;

                              var re = DateFormat('dd-MM-yyyy').format(total);
                              print(nodata);
                              return dataMemberSingle[0].loans.length <= 0
                                  ? Center(child: Text("Tidak Ada Barang"))
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 2, 2, 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // color: Colors.lightBlue[100],
                                                  color: Colors.blueGrey[200],
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors
                                                          .blueGrey[200])),
                                              child: ExpansionTileCard(
                                                leading: CircleAvatar(
                                                    child: Icon(
                                                        Icons.attach_money)),
                                                title: Text(
                                                    '${currencyFormatter.format(barang[i].total)}'),
                                                subtitle: Text(widget.name),
                                                children: <Widget>[
                                                  Divider(
                                                    thickness: 1.0,
                                                    height: 1.0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 3.0,
                                                          vertical: 3.0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                'Borrower',
                                                              ),
                                                              subtitle: Text(
                                                                  widget.name),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Borrowed Amount',
                                                              ),
                                                              subtitle: Text(
                                                                  '${currencyFormatter.format(barang[i].total)}'),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Date Returned',
                                                              ),
                                                              subtitle:
                                                                  Text(re),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        )
                                      ],
                                    );
                            },
                          ),
                  ),

                  /////////////////////////////////
                  /////////////////////////////////
                  Scaffold(
                    body: dataMemberSingle == null
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataMemberSingle[0].deposit.length,
                            itemBuilder: (context, i) {
                              var deposit = dataMemberSingle[0].deposit;
                              var total = deposit[i].createdAt;
                              var re = DateFormat('dd-MM-yyyy').format(total);
                              return deposit.length <= 0
                                  ? Center(child: Text("Tidak Ada Deposit"))
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: displayHeight(context) * 0.02,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 2, 2, 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // color: Colors.lightBlue[100],
                                                  color: Colors.blueGrey[200],
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors
                                                          .blueGrey[200])),
                                              child: ExpansionTileCard(
                                                leading: CircleAvatar(
                                                    child: Icon(
                                                        Icons.attach_money)),
                                                title: Text(
                                                    '${currencyFormatter.format(deposit[i].total)}'),
                                                subtitle: Text("Savers = " +
                                                    '${widget.name}'),
                                                children: <Widget>[
                                                  Divider(
                                                    thickness: 1.0,
                                                    height: 1.0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 3.0,
                                                          vertical: 3.0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                'Savers',
                                                              ),
                                                              subtitle: Text(
                                                                  widget.name),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Total saved',
                                                              ),
                                                              subtitle: Text(
                                                                  '${currencyFormatter.format(deposit[i].total)}'),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Saved on',
                                                              ),
                                                              subtitle:
                                                                  Text(re),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        )
                                      ],
                                    );
                            },
                          ),
                  ),
                  ///////////////////////
                  ///////////////////////
                  Scaffold(
                    body: dataMemberSingle == null
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : ListView.builder(
                            itemCount: dataMemberSingle[0].barang.length,
                            itemBuilder: (context, i) {
                              var data = dataMemberSingle[0].barang;
                              return data.length <= 0
                                  ? Center(child: Text("Tidak Ada Barang"))
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: displayHeight(context) * 0.02,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 2, 2, 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  // color: Colors.lightBlue[100],
                                                  color: Colors.blueGrey[200],
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors
                                                          .blueGrey[200])),
                                              child: ExpansionTileCard(
                                                leading: CircleAvatar(
                                                    child: Icon(
                                                        Icons.attach_money)),
                                                title: Text(data[i].nameBarang),
                                                
                                                children: <Widget>[
                                                  Divider(
                                                    thickness: 1.0,
                                                    height: 1.0,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 3.0,
                                                          vertical: 3.0,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              title: Text(
                                                                'Entrusted goods',
                                                              ),
                                                              subtitle: Text(data[
                                                                      i]
                                                                  .nameBarang),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Stock',
                                                              ),
                                                              subtitle: Text(
                                                                (data[i]
                                                                    .stock
                                                                    .toString()),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Type',
                                                              ),
                                                              subtitle: Text(
                                                                  data[i]
                                                                      .jenis),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Price',
                                                              ),
                                                              subtitle: Text(
                                                                  '${currencyFormatter.format(data[i].harga)}'),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'Image',
                                                              ),
                                                              subtitle:
                                                                  Container(
                                                                width: displayHeight(
                                                                        context) *
                                                                    0.01,
                                                                height: displayHeight(
                                                                        context) *
                                                                    0.15,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            100),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        // color: Colors.lightBlue[100],
                                                                        image: new DecorationImage(
                                                                            image: new NetworkImage(
                                                                                'http://coperationv2.herokuapp.com/img/${data[i].image}'),
                                                                            fit: BoxFit
                                                                                .fitHeight,
                                                                            scale:
                                                                                2),
                                                                        border: Border.all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                Colors.black)),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ButtonBar(
                                                    alignment: MainAxisAlignment
                                                        .spaceAround,
                                                    buttonHeight: 52.0,
                                                    buttonMinWidth: 90.0,
                                                    children: <Widget>[
                                                      FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0)),
                                                        onPressed: () {
                                                          productDeletedata(
                                                              data[i].id);
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                            ),
                                                            Text('Delete Goods',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0)),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return EditOtherProduct(
                                                              idoper:
                                                                  data[i].id,
                                                              nameoper:
                                                                  widget.name,
                                                              nameBarangoper:
                                                                  data[i]
                                                                      .nameBarang,
                                                              stockoper: data[i]
                                                                  .stock
                                                                  .toString(),
                                                              hargaoper: data[i]
                                                                  .harga
                                                                  .toString(),
                                                              jenisoper:
                                                                  data[i].jenis,
                                                            );
                                                          }));
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          2.0),
                                                            ),
                                                            Text('Edit Goods',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .yellow,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        )
                                      ],
                                    );
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
