import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../saving_model.dart';

Future makeSavingsRequest(int data_id, int user_id, String total) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"data_id": user_id.toString(),"total": total,};
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

  Future<List> getDataSavings(String name) async {
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

Future withdrawMoney(int totalbaru, int totallama, int id) async {
  String token = await storage.read(key: 'namatoken');
  int finaldata = totallama-totalbaru;
  print(finaldata);
  try {
    var datass = {"total": finaldata.toString()};
    print(datass);
    // print(id);

    var hasil = await http.put(
        'http://coperationv2.herokuapp.com/api/nabung-edit/${id}',
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