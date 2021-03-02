import 'package:end_project/pages/penjual/tools/transaksi/allProduct/product_model/titipan_penjual.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../product_model/koperasi_penjual.dart';

String token;
final storage = new FlutterSecureStorage();

class KoperasiGetpenjual {
  Future<KoperasiPenjual> getProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'https://coperationv2.herokuapp.com/api/barang-koperasi/show',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }
      final data = koperasiPenjualFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

Future editKoperasiProduct(int count,int stock, int id) async {
  String token = await storage.read(key: 'namatoken');
  int finaldata = stock-count;
  print(finaldata);
  try {
    var datass = {"stock": finaldata.toString()};
    print(datass);
    print(id);

    var hasil = await http.put(
        'http://coperationv2.herokuapp.com/api/barang-koperasi/stock/${id}',
        headers: {'Authorization': 'Bearer $token'},
        body: (datass)
        );
    if (hasil.statusCode == 201) {
      print("Sukses menyimpan data");
      return true;
    } else {
      print(hasil.statusCode);
      // print(data);
      return false;
    }
  } 
  catch (e) {
    print("Error pada catch $e");
  }
}

Future editPenjualProduct(int count,int stock, int id) async {
  String token = await storage.read(key: 'namatoken');
  int finaldata = stock-count;
  print(finaldata);
  try {
    var datass = {"stock": finaldata.toString()};
    print(datass);
    print(id);

    var hasil = await http.put(
        'http://coperationv2.herokuapp.com/api/barang-penjual/stock/${id}',
        headers: {'Authorization': 'Bearer $token'},
        body: (datass)
        );
    if (hasil.statusCode == 201) {
      print("Sukses menyimpan data");
      return true;
    } else {
      print(hasil.statusCode);
      // print(data);
      return false;
    }
  } 
  catch (e) {
    print("Error pada catch $e");
  }
}



class TitipanGetpenjual {
  Future<TitipanPenjual> getProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'https://coperationv2.herokuapp.com/api/barang-penjual/show',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }
      final data = titipanPenjualFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}
