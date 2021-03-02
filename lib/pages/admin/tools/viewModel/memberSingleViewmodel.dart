import 'dart:convert';

import 'package:end_project/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/memberlistModel.dart';
import '../model/makeData.dart';
import '../model/productModel.dart';
import '../model/otherproduct.dart';
import '../model/memberListSingle.dart';

String token;
final storage = new FlutterSecureStorage();  

Future deleteLoan(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    // print(data);

    var hasil = await http.delete(
      "https://coperationv2.herokuapp.com/api/pinjam/${id}",
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (hasil.statusCode == 200) {
      print("Sukses Menghapus data");
      return true;
    } else {
      print(hasil.statusCode.toString());
      print("Gagal Menghapus Data");
      print(data);
      // print(token);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future deleteDeposit(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    // print(data);

    var hasil = await http.delete(
      "https://coperationv2.herokuapp.com/api/nabung/${id}",
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (hasil.statusCode == 200) {
      print("Sukses Menghapus data");
      return true;
    } else {
      print(hasil.statusCode.toString());
      print("Gagal Menghapus Data");
      print(data);
      // print(token);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future deleteproductSingle(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    // print(data);

    var hasil = await http.delete(
      "https://coperationv2.herokuapp.com/api/barang-penjual/${id}",
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (hasil.statusCode == 200) {
      print("Sukses Menghapus data");
      return true;
    } else {
      print(hasil.statusCode.toString());
      print("Gagal Menghapus Data");
      print(data);
      // print(token);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future deletemember(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
      http.Response hasil = await http.delete(
          "http://coperationv2.herokuapp.com/api/user/delete/${id}",
          headers: {'Authorization': 'Bearer $token'});

      if (hasil.statusCode == 200) {
        print("Sukses menampilkan Single data");
        
        // List<dynamic> data = json.decode(hasil.body);

        // print(data);
        return true;
        // return data2;

      } else {
        print("Gagal menampikan Single data");
        return false;
      }
    } catch (e) {
    print("Error pada catch $e");
  }
}