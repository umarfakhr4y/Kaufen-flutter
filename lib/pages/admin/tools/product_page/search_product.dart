part of '../tools.dart';

class SearchProductList extends StatefulWidget {
  final String value;
  SearchProductList({this.value});

  @override
  SearchProductListState createState() => SearchProductListState();
}

class SearchProductListState extends State<SearchProductList> {
  ProductListApi dataProduct;
  var asd;

  TextEditingController editingController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController harga = TextEditingController();
  bool _obscureText = true;
  bool _isChecked = true;
  bool _loading = false;
  var productvalid;
  var jenisvalid;
  var stockvalid;
  var hargavalid;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // final _formKey = GlobalKey<FormState>();

  void getProductsearch() {
    ProductGetSearch().getProductSearch(widget.value).then((value) {
      setState(() {
        dataProduct = value;
      });
    });
  }

  void noProduct() {
    ProductGetSearch().getProductSearch(widget.value).then((value) => {
          if (value == "asd")
            {
              Alert(
                context: context,
                type: AlertType.error,
                title: "Gagal",
                desc: "Data Gagal Dihapus",
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

  void hapusProduct(id) {
    deleteProduct(id).then((value) => {
          if (value == true)
            {
              Alert(
                context: context,
                type: AlertType.success,
                title: "Sukses",
                desc: "Data Sukses Dihapus",
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
                title: "Gagal",
                desc: "Data Gagal Dihapus",
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
      getProductsearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor("#305a84"), HexColor("#97c7eb")])),
        ),
        elevation: 0,
        shadowColor: Colors.lightBlue[200],
      ),
      body: dataProduct == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
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
                          "Result",
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
                                border:
                                    Border.all(width: 2, color: Colors.white)),
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
                                          ListTile(
                                            title: Text(
                                              'Stock',
                                            ),
                                            subtitle:
                                                Text(dataProduct.data[i].stock),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Price',
                                            ),
                                            subtitle:
                                                Text(dataProduct.data[i].harga),
                                          ),
                                          ListTile(
                                                  title: Text(
                                                    'Image',
                                                  ),
                                                  onTap: () {},
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
                                                            fit: BoxFit.fitHeight,
                                                            scale: 2),
                                                        ),
                                                  ))
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
                                              idoper: dataProduct.data[i].id);
                                          ;
                                        }));
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.edit),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                        hapusProduct(dataProduct.data[i].id);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
