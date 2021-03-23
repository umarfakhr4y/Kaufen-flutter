import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:end_project/auth/auth.dart';
import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

String token;
final storage = new FlutterSecureStorage();

Future<List> getSingleMemberUser() async {
  String token = await storage.read(key: 'namatoken');
  try {
    http.Response hasil = await http.get(
        "http://coperationv2.herokuapp.com/api/data",
        headers: {'Authorization': 'Bearer $token'});

    if (hasil.statusCode == 200) {
      print("Sukses menampilkan Single data");
      final data = memberListSIngleFromJson(hasil.body);
      // List<dynamic> data = json.decode(hasil.body);

      // print(data);
      return data;
      // return data2;

    } else {
      print("Gagal menampikan Single data");
      return null;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future editTitipan(String name_barang, String jenis, String stock, String harga, int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {
      "name_barang": name_barang,
      "stock": stock,
      "jenis": jenis,
      "harga": harga,
    };
    print(data);

    var hasil = await http.put(
        'https://coperationv2.herokuapp.com/api/barang-penjual/${id}',
        body: (data),
        headers: {'Authorization': 'Bearer $token'});
    if (hasil.statusCode == 200) {
      print("Sukses menyimpan data");
      return true;
    } else {
      print(hasil.statusCode);
      // print(data);
      return false;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future editImagee(int id, File image) async {
  String token = await storage.read(key: 'namatoken');
  Response response;
  Dio dio = new Dio();
  String fileName = image.path.split('/').last;
  // print(fileName);
  FormData formData = new FormData.fromMap({
    
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  });

  dio.options.headers["Authorization"] = "Bearer $token";
  try {
    response = await dio.post(
        "https://coperationv2.herokuapp.com/api/barang-penjual/update-image/${id}",
        data: formData);
    print(response);
    return true;
  } catch (e) {
    if (e is DioError) {
      //handle DioError here by error type or by error code
      print('error dio: ${e.response.data}');
      return false;
    } else {
      // print(e.message);
      return false;
    }
    // print('error: ${e.toString()}');
  }
}

// Future makeTitipan(String name, String name_barang, String stock, String jenis, String harga) async {
//   String token = await storage.read(key: 'namatoken');
//   try {
//     var data = {
//       "name": name,
//       "name_barang": name_barang,
//       "stock": stock,
//       "jenis": jenis,
//       "harga": harga,
//     };
//     print(data);

//     var hasil = await http.post(
//         'https://coperationv2.herokuapp.com/api/barang-penjual',
//         body: (data),
//         headers: {'Authorization': 'Bearer $token'});
//     if (hasil.statusCode == 200) {
//       print("Sukses menyimpan data");
//       return true;
//     } else {
//       print(hasil.statusCode);
//       // print(data);
//       return false;
//     }
//   } catch (e) {
//     print("Error pada catch $e");
//   }
// }



Future deleteTitipan(int id) async {
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
