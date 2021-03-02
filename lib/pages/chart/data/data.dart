import '../model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'model/koperasi.dart';

KoperasiRekap rekapkop;
final storage = new FlutterSecureStorage();

Future<KoperasiRekap> getData() async {
  var response;
  var data;
  String token = await storage.read(key: 'namatoken');

  try {
    response = await http.get(
        'http://coperationv2.herokuapp.com/api/barang-koperasi/show',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      print("Gagal login");
      return null;
    }

    data = koperasiRekapFromJson(response.body.toString());
    print("Sukses ngambil data ngab");
    return data;
  } catch (e) {
    print("Error pada catch $e");
  }
}

void getKoperasi() {
  getData().then((value) {
    rekapkop = value;
  });
}

void initState() {
  initState();
  getKoperasi();
}

class BarData {
  static int interval = 5;

  static List<Data> barData = [
    Data(
      id: 0,
      name: 'Mon',
      y: 15,
      color: Color(0xff19bfff),
    ),
  ];
}
