part of 'tools.dart';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: SizedBox(
                              height: displayHeight(context) * 0.25,
                              width: displayHeight(context) * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
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
                                          Icons.add_circle,
                                          color: Colors.white,
                                          size: displayHeight(context) * 0.08,
                                        ),
                                      ),
                                      Text("Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: displayHeight(context) *
                                                  0.025)),
                                      Text("New Member",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: displayHeight(context) *
                                                  0.02))
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MemberList()),
                                );
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
                                        Icons.people_alt_rounded,
                                        color: Colors.white,
                                        size: displayHeight(context) * 0.08,
                                      ),
                                    ),
                                    Text("Accounts",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: displayHeight(context) *
                                                0.025)),
                                    Text("List",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                displayHeight(context) * 0.02))
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.015,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.2,
                          width: displayHeight(context) * 0.2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductList()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // color: Colors.lightBlue[100],
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/buku.png'),
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
                                      Icons.add_circle,
                                      color: Colors.white,
                                      size: displayHeight(context) * 0.08,
                                    ),
                                  ),
                                  Text("Kaufen",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              displayHeight(context) * 0.025)),
                                  Text("Products",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              displayHeight(context) * 0.025)),
                                ],
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtherProductList()),
                                );
                              },
                              child: new Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.lightBlue[100],
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/beans.png'),
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
                                        Icons.local_drink_rounded,
                                        color: Colors.white,
                                        size: displayHeight(context) * 0.08,
                                      ),
                                    ),
                                    Text("Deposited ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: displayHeight(context) *
                                                0.025)),
                                    Text("Products",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                displayHeight(context) * 0.025))
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.015,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.2,
                          width: displayHeight(context) * 0.2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DebtList()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // color: Colors.lightBlue[100],
                                  image: new DecorationImage(
                                    image:
                                        new ExactAssetImage('assets/uang.png'),
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
                                      Icons.money,
                                      color: Colors.white,
                                      size: displayHeight(context) * 0.08,
                                    ),
                                  ),
                                  Text("Debt",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              displayHeight(context) * 0.025)),
                                
                                ],
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SavingListAdmin()),
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
                                        Icons.attach_money_rounded,
                                        color: Colors.white,
                                        size: displayHeight(context) * 0.08,
                                      ),
                                    ),
                                    Text("Saving ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: displayHeight(context) *
                                                0.025)),
                                    Text("List",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                displayHeight(context) * 0.025))
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
