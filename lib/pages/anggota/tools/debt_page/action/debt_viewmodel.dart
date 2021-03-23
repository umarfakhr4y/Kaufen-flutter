import 'dart:convert';

import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/profilePage/model/profilemodel.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Data_model.dart';

Future getName() async {
  var response;
  String token = await storage.read(key: 'namatoken');

  try {
    response = await http.get(
        'http://coperationv2.herokuapp.com/api/user/detail',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      print("Gagal login");
      return null;
    }

    data = dataLoginFromJson(response.body.toString());
    print("Sukses ngambil data ngab");
    return data;
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future<List> getData(String name) async {
  String token = await storage.read(key: 'namatoken');
  try {
    http.Response hasil = await http.get(
        "http://coperationv2.herokuapp.com/api/data/${name}",
        headers: {'Authorization': 'Bearer $token'});

    if (hasil.statusCode == 200) {
      // print("Sukses menampilkan Single data");
      final data = memberListSIngleFromJson(hasil.body);
      // List<dynamic> data = json.decode(hasil.body);
      print("Berhasilllllllll");
      // print(data);
      return data;
      // return data2;

    } else {
      print("Gagal menampikan Single data");
      print(hasil.statusCode);
      return null;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future makeDebtRequest(int data_id, int user_id, String total, String kembali) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"data_id": user_id.toString(),"total": total, "return": kembali};
    print(data);

    var hasil = await http.post("http://coperationv2.herokuapp.com/api/pinjam-req",
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: (data));
    if (hasil.statusCode == 200) {
      print("Sukses menyimpan data");
      return true;
    } else {
      print(hasil.statusCode.toString());
      print(data);
      // print(token);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}


Future makeSavingsRequest(int data_id, int user_id, String total) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"data_id": user_id.toString(), "user_id": data_id.toString(),"total": total,};
    print(data);

    var hasil = await http.post("http://coperationv2.herokuapp.com/api/nabung-req",
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: (data));
    if (hasil.statusCode == 200) {
      print("Sukses menyimpan data");
      return true;
    } else {
      print(hasil.statusCode.toString());
      print(data);
      // print(token);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future deleteDebt(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    // print(data);

    var hasil = await http.post(
      "https://coperationv2.herokuapp.com/api/pinjam-del/${id}",
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

Future payDebt(int totalbaru, int totallama, int id) async {
  String token = await storage.read(key: 'namatoken');
  int finaldata = totallama-totalbaru;
  print(finaldata);
  try {
    var datass = {"total": finaldata.toString()};
    print(datass);
    print(id);

    var hasil = await http.put(
        'http://coperationv2.herokuapp.com/api/pinjam-edit/${id}',
        headers: {'Authorization': 'Bearer $token'},
        body: (datass)
        );
    if (hasil.statusCode == 200) {
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