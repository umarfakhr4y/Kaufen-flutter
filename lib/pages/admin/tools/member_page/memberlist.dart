part of '../tools.dart';

class MemberList extends StatefulWidget {
  @override
  MemberListState createState() => MemberListState();
}

class MemberListState extends State<MemberList> {
  TextEditingController editingController = TextEditingController();

  MemberListmodel memberAdmin;
  MemberListmodel memberPenjual;
  MemberListmodel memberAnggota;

  void getAdmin() {
    getMemberAdmin().then((value) {
      setState(() {
        memberAdmin = value;
      });
    });
  }

  void getPenjual() {
    getMemberPenjual().then((value) {
      setState(() {
        memberPenjual = value;
      });
    });
  }

  void getAnggota() {
    getMemberAnggota().then((value) {
      setState(() {
        memberAnggota = value;
      });
    });
  }

  void userDelete(id) {
    deleteUser(id).then((value) {
      if (value == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Sukses",
          desc: "Sukses Menghapus User",
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
                // Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Gagal",
          desc: "Gagal Menghapus User",
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
    getAdmin();
    getPenjual();
    getAnggota();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kaufen"),
          actions: <Widget>[
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
          leading: IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              //Menangani kejadian saat menu home diklik
              onPressed: () {
                Navigator.pop(context);
              }),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Admin",
              ),
              Tab(
                text: "Seller",
              ),
              Tab(
                text: "Member",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
                body: memberAdmin == null
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
                                    "Admin List",
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))),
                          Expanded(
                            child: ListView.builder(
                              itemCount: memberAdmin.user.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                                  child: GestureDetector(
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.lightBlue[100],
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
                                          Text(memberAdmin.user[i].name ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.025)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      print(memberAdmin.user[i].data);
                                      if (memberAdmin.user[i].data.length <=
                                          0) {
                                        print("Anggota tidak Memiliki data");
                                        Alert(
                                          context: context,
                                          type: AlertType.info,
                                          title: "Member doesn't have data yet",
                                          desc: "Immediately complete the data independently",
                                          buttons: [
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Back",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              width: 80,
                                            ),
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Delete User",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              onPressed: () {
                                                userDelete(
                                                    memberAdmin.user[i].id);
                                                // print(memberAdmin.user[i].id);
                                              },
                                              width: 80,
                                            ),
                                          ],
                                        ).show();
                                      } else if (memberAdmin
                                              .user[i].data.length >=
                                          1) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MemberSingle(
                                            name: memberAdmin.user[i].name,
                                            id: memberAdmin.user[i].id,
                                            
                                          );
                                        }));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),

            /////////////////////////////////
            /////////////////////////////////
            Scaffold(
                body: memberPenjual == null
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
                                    "Seller List",
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))),
                          Expanded(
                            child: ListView.builder(
                              itemCount: memberPenjual.user.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                                  child: GestureDetector(
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.lightBlue[100],
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
                                          Text(memberPenjual.user[i].name ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.025)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      print(memberPenjual.user[i].data);
                                      if (memberPenjual.user[i].data.length <=
                                          0) {
                                        print("Anggota tidak Memiliki data");
                                        Alert(
                                          context: context,
                                          type: AlertType.info,
                                          title: "Member doesn't have data yet",
                                          desc: "Immediately complete the data independently",
                                          buttons: [
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Back",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              width: 80,
                                            ),
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Delete User",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              onPressed: () {
                                                userDelete(
                                                    memberPenjual.user[i].id);
                                                // print(memberPenjual.user[i].id);
                                              },
                                              width: 80,
                                            ),
                                            
                                          ],
                                        ).show();
                                      } else if (memberPenjual
                                              .user[i].data.length >=
                                          1) {
                                        print("Anggota Memiliki data");
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MemberSingle(
                                            name: memberPenjual.user[i].name,
                                            id: memberPenjual.user[i].id,
                                          );
                                          ;
                                        }));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
            ///////////////////////
            ///////////////////////
            Scaffold(
                body: memberAnggota == null
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
                                    "Member List",
                                    style: TextStyle(
                                        fontSize: displayHeight(context) * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))),
                          Expanded(
                            child: ListView.builder(
                              itemCount: memberAnggota.user.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 1),
                                  child: GestureDetector(
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.lightBlue[100],
                                          gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [HexColor("#305a84"), HexColor("#97c7eb")]),
                                          border: Border.all(
                                              width: 2, color: Colors.white)),
                                      child: Column(
                                        children: [
                                          Text(memberAnggota.user[i].name ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      displayHeight(context) *
                                                          0.025)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      print(memberAnggota.user[i].data);
                                      if (memberAnggota.user[i].data.length <=
                                          0) {
                                        print("Anggota tidak Memiliki data");
                                        Alert(
                                          context: context,
                                          type: AlertType.info,
                                          title: "Member doesn't have data yet",
                                          desc: "Immediately complete the data independently",
                                          buttons: [
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Back",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              width: 80,
                                            ),
                                            DialogButton(
                                              color: Colors.red,
                                              child: Text(
                                                "Delete User",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              onPressed: () {
                                                userDelete(
                                                    memberAnggota.user[i].id);
                                                // print(memberAnggota.user[i].id);
                                              },
                                              width: 80,
                                            ),

                                          ],
                                        ).show();
                                      } else if (memberAnggota
                                              .user[i].data.length >=
                                          1) {
                                        print("Anggota Memiliki data");
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MemberSingle(
                                            name: memberAnggota.user[i].name,
                                            id: memberAnggota.user[i].id,
                                          );
                                          ;
                                        }));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
