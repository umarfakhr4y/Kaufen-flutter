import 'package:end_project/auth/auth.dart';
import 'package:flutter/material.dart';
import 'model/AcceptedDebt.dart';
import 'model/debtList.dart';
import 'package:http/http.dart' as http;

Future getListAcceptedDebt() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'http://coperationv2.herokuapp.com/api/pinjam',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }
      final data = acceptedDebtFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }

Future getListDebt() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'http://coperationv2.herokuapp.com/api/pinjam-req/list',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }
      final data = debtListdataFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }

  
  
  Future acceptDebt(int id) async {
    String token = await storage.read(key: 'namatoken');
    try {
      var data = {"waiting_confirmation": "accepted"};
      print(data);

      var hasil =
          await http.post("http://coperationv2.herokuapp.com/api/pinjam-accept/${id}",
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

//   Future addDebt(int nominal) async {
//   String token = await storage.read(key: 'namatoken');
//   try {
//     var data = {"nominal": nominal.toString()};
//     print(data);

//     var hasil = await http.post("http://coperationv2.herokuapp.com/api/pinjam/pay",
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         body: (data));
//     if (hasil.statusCode == 200) {
//       print("Sukses menyimpan data");
//       return true;
//     } else {
//       print(hasil.statusCode.toString());
//       print(data);
//       // print(token);
//       // print(data);
//       return false;
//     }
//   } catch (e) {
//     print("Error pada catch $e");
//   }
// }