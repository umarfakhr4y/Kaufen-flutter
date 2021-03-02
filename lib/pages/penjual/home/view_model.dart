import 'dart:convert';

import 'package:end_project/pages/penjual/tools/transaksi/allProduct/product_model/titipan_penjual.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../history_home/model/pinjamanModel.dart';
import '../../history_home/model/tabunganModel.dart';

String token;
final storage = new FlutterSecureStorage();

class GETpinjaman {
  Future <Pinjaman> getProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'https://coperationv2.herokuapp.com/api/pinjam/show',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print(response.statusCode);
        return null;
      }
      final data = pinjamanFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

class GETtabungan {
  Future <Tabungan> getProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'https://coperationv2.herokuapp.com/api/nabung/show',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print(response.statusCode);
        return null;
      }
      final data = tabunganFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}