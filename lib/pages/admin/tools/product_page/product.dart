  part of '../tools.dart';

  class ProductList extends StatefulWidget {
    @override
    ProductListState createState() => ProductListState();
  }

  class KoperasiKeys {
    static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    static final GlobalKey<ScaffoldState> _scaffoldKey =
        GlobalKey<ScaffoldState>();
  }

  class ProductListState extends State<ProductList> {
    ProductListApi dataProduct;

    TextEditingController editingController = TextEditingController();
    TextEditingController user_id = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController jenis = TextEditingController();
    TextEditingController stock = TextEditingController();
    TextEditingController harga = TextEditingController();
    final currencyFormatter = new intl.NumberFormat.currency(locale: 'ID');

    final oCcy = new intl.NumberFormat.simpleCurrency();

    bool _obscureText = true;
    bool _isChecked = true;
    bool _loading = false;
    var productvalid;
    var jenisvalid;
    var stockvalid;
    var hargavalid;
    bool _visible = true;
    PanelController _pc1 = new PanelController();
    PanelController _pc2 = new PanelController();

    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    // final _formKey = GlobalKey<FormState>();

    void getProduct() {
      ProductGet().getProduct().then((value) {
        setState(() {
          dataProduct = value;
        });
      });
    }

    void hapusProduct(id) {
      deleteProduct(id).then((value) => {
            if (value == true)
              {
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Success",
                  desc: "Goods Successfully deleted",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AdminPage()),
                        (Route<dynamic> route) => false,
                      ),
                      width: 120,
                    )
                  ],
                ).show()
              }
            else
              {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "Failed",
                  desc: "Failed Deleting Goods",
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
                ).show()
              }
          });
    }

    // void initState() {
    //   super.initState();
    //   getProduct();
    // }
    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      setState(() {
        getProduct();
      });
    }

    SearchBar searchBar;

    AppBar buildAppBar(BuildContext context) {
      return new AppBar(
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
          actions: [
            searchBar.getSearchAction(context),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Addproduct();
                }));
              },
            )
          ]);
    }

    void onSubmitted(String value) {
      print(value);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchProductList(
          value: value,
        );
      }));
    }

    ProductListState() {
      searchBar = new SearchBar(
          inBar: false,
          buildDefaultAppBar: buildAppBar,
          setState: setState,
          onSubmitted: onSubmitted,
          onCleared: () {
            print("cleared");
          },
          onClosed: () {
            print("closed");
          });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: searchBar.build(context),
        // key: KoperasiKeys._scaffoldKey,
        body: dataProduct == null
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
                            "Kaufen Product",
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
                        var intharga = int.parse(dataProduct.data[i].harga);
                        return Column(
                          children: [
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                              child: GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.lightBlue[100],
                                      color: Colors.blueGrey[200],
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: ExpansionTileCard(
                                    title: Text(dataProduct.data[i].name),
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
                                                Stack(
                                                  fit: StackFit.passthrough,
                                                  children: [
                                                    Container(
                                                      // width: displayHeight(
                                                      //         context) *
                                                      //     0.015,
                                                      height:
                                                          displayHeight(context) *
                                                              0.25,
                                                      padding:
                                                          EdgeInsets.all(100),
                                                      decoration: BoxDecoration(
                                                        // color: Colors.lightBlue[100],
                                                        image: new DecorationImage(
                                                            image: new NetworkImage(
                                                                'http://coperationv2.herokuapp.com/img/${dataProduct.data[i].image}'),
                                                            fit: BoxFit.fitHeight,
                                                            scale: 2),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: displayHeight(
                                                                context) *
                                                            0.015,
                                                        right: displayHeight(
                                                                context) *
                                                            0.015,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return EditImageKoperasi(
                                                                  id_oper:
                                                                      dataProduct
                                                                          .data[i]
                                                                          .id,
                                                                  imageOld:
                                                                      dataProduct
                                                                          .data[i]
                                                                          .image);
                                                            }));
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .blueAccent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                IconButton(
                                                                  color: Colors
                                                                      .black,
                                                                  iconSize:
                                                                      displayHeight(
                                                                              context) *
                                                                          0.03,
                                                                  icon: Icon(Icons
                                                                      .edit_outlined),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                    Positioned(
                                                        bottom: displayHeight(
                                                                context) *
                                                            0.015,
                                                        left: displayHeight(
                                                                context) *
                                                            0.015,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Stock : ${dataProduct.data[i].stock.toString()}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          displayHeight(context) *
                                                                              0.02,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: displayHeight(
                                                                      context) *
                                                                  0.005,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    currencyFormatter
                                                                        .format(
                                                                            intharga),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          displayHeight(context) *
                                                                              0.02,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                                
                                              ],
                                            )),
                                      ),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.spaceAround,
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
                                                return EditProduct(
                                                    nameoper:
                                                        dataProduct.data[i].name,
                                                    hargaoper:
                                                        dataProduct.data[i].harga,
                                                    jenisoper:
                                                        dataProduct.data[i].jenis,
                                                    stockoper:
                                                        dataProduct.data[i].stock,
                                                    idoper:
                                                        dataProduct.data[i].id);
                                                ;
                                              }));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.edit),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 2.0),
                                                ),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                          FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            onPressed: () {
                                              // print(dataProduct[i].id);
                                              hapusProduct(
                                                  dataProduct.data[i].id);
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 2.0),
                                                ),
                                                Text('Remove',
                                                    style: TextStyle(
                                                      color: Colors.red,
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
      );
    }

    Widget _floatingPanel() {
      return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  color: Colors.grey,
                ),
              ]),
          margin: const EdgeInsets.fromLTRB(24.0, 100.0, 24.0, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: KoperasiKeys._formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Add Product",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      Divider(),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: name,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Product name",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (productValue) {
                          if (productValue.isEmpty) {
                            return 'Masukan Nama Product';
                          }
                          productvalid = productValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: jenis,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Jenis",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (jenisValue) {
                          if (jenisValue.isEmpty) {
                            return 'Masukan jenis';
                          }
                          jenisvalid = jenisValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: stock,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Stock",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (stockValue) {
                          if (stockValue.isEmpty) {
                            return 'Masukan stock';
                          }
                          stockvalid = stockValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      TextFormField(
                        controller: harga,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Harga",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (hargaValue) {
                          if (hargaValue.isEmpty) {
                            return 'Masukan harga';
                          }
                          hargavalid = hargaValue;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 15, right: 15),
                              child: Text(
                                _loading ? 'Processing' : 'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            color: HexColor("#305a84"),
                            disabledColor: Colors.grey,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: () {},
                            // onPressed: () {
                            //   if (_formKey.currentState.validate()) {
                            //     print('login dipencet');
                            //   }
                            // },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
