part of '../tools.dart';

class OtherProductList extends StatefulWidget {
  @override
  OtherProductListState createState() => OtherProductListState();
}

class OtherProductListState extends State<OtherProductList> {
  TextEditingController editingController = TextEditingController();
  final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');

  OtherproductList dataProduct;

  void getMember() {
    OtherProductGet().getOtherProduct().then((value) {
      setState(() {
        dataProduct = value;
      });
    });
  }

  void initState() {
    super.initState();
    getMember();
  }

  void productDeletedata(id) {
    deleteTitipan(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Success Deleting Deposited Product",
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
          desc: "Failed Deleting Deposited Product",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Kaufen"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddOtherproduct();
                  }));
                },
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
            ),
            elevation: 0,
            shadowColor: Colors.lightBlue[200],
            // actions: <Widget>[
            //   new IconButton(
            //     icon: new Icon(Icons.replay_10),
            //     onPressed: () {},
            //   ),
            // ],
            leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              //Menangani kejadian saat menu home diklik
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: dataProduct == null
            ? Center(
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
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
                            "Deposited Product",
                            style: TextStyle(
                                fontSize: displayHeight(context) * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ))),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataProduct.data.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: GestureDetector(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.lightBlue[100],
                                  color: Colors.blueGrey[200],
                                  border: Border.all(
                                      width: 2, color: Colors.white)),
                              child: Column(
                                children: [
                                  ExpansionTileCard(
                                    leading: CircleAvatar(
                                        child: Icon(
                                            Icons.airplanemode_active_rounded)),
                                    title: Text(dataProduct.data[i].nameBarang),
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
                                                    'Goods Type',
                                                  ),
                                                  subtitle: Text(dataProduct
                                                      .data[i].jenis),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'Stock',
                                                  ),
                                                  subtitle: Text(dataProduct
                                                      .data[i].stock
                                                      .toString()),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'Price',
                                                  ),
                                                  subtitle: Text(
                                                      currencyFormatter.format(
                                                          dataProduct
                                                              .data[i].harga)),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    'Image',
                                                  ),
                                                  subtitle: Container(
                                                    width:
                                                        displayHeight(context) *
                                                            0.01,
                                                    height:
                                                        displayHeight(context) *
                                                            0.15,
                                                    padding:
                                                        EdgeInsets.all(100),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        // color: Colors.lightBlue[100],
                                                        image: new DecorationImage(
                                                            image: new NetworkImage(
                                                                'http://coperationv2.herokuapp.com/img/${dataProduct.data[i].image}'),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            scale: 2),
                                                        ),
                                                  ),
                                                ),
                                                // ListTile(
                                                //   title: Text(
                                                //     'Harga',
                                                //   ),
                                                //   subtitle: Text(
                                                //       dataProduct.data[i].harga),
                                                // ),
                                              ],
                                            )),
                                      ),
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceAround,
                                        buttonHeight: 52.0,
                                        buttonMinWidth: 90.0,
                                        children: <Widget>[
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EditOtherProduct(
                                                  idoper:
                                                      dataProduct.data[i].id,
                                                  user_idoper: dataProduct
                                                      .data[i].userId,
                                                  nameoper:
                                                      dataProduct.data[i].name,
                                                  nameBarangoper: dataProduct
                                                      .data[i].nameBarang,
                                                  stockoper: dataProduct
                                                      .data[i].stock
                                                      .toString(),
                                                  hargaoper: dataProduct
                                                      .data[i].harga
                                                      .toString(),
                                                  jenisoper:
                                                      dataProduct.data[i].jenis,
                                                );
                                              }));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.edit,
                                                    color: Colors.blue),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            onPressed: () {
                                              productDeletedata(
                                                  dataProduct.data[i].id);
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                ),
                                                Text(
                                                  'Hapus',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}
