import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'dart:io';

String token;
final storage = new FlutterSecureStorage();

Future makeTitipan( String name_barang, String stock, String jenis, String harga, int user_id, File image) async {
  String token = await storage.read(key: 'namatoken');
  Response response;
  Dio dio = new Dio();
  String fileName = image.path.split('/').last;
  // print(fileName);
  FormData formData = new FormData.fromMap({
    "user_id": user_id,
    "data_id": user_id,
    "name_barang": name_barang,
    "stock": stock,
    "jenis": jenis,
    "harga": harga,
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  });

  dio.options.headers["Authorization"] = "Bearer $token";
  try {
    response = await dio.post(
        "http://coperationv2.herokuapp.com/api/barang-penjual",
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
