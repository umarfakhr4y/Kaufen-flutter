import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/memberlistModel.dart';
import '../model/productModel.dart';
import '../model/otherproduct.dart';

String token;
final storage = new FlutterSecureStorage();

class ProductGet {
  Future<ProductListApi> getProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'http://coperationv2.herokuapp.com/api/barang-koperasi',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }
      final data = productListApiFromJson(response.body);
      print("Sukses ngambil Product nih");

      // print(response.body);
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

Future editImagekoperasi(int id, File image) async {
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
        "https://coperationv2.herokuapp.com/api/barang-koperasi/update-image/${id}",
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

class ProductGetSearch {
  // ignore: missing_return
  Future<ProductListApi> getProductSearch(String value) async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get(
          'https://coperationv2.herokuapp.com/api/barang-koperasi?keyword=${value}',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }

      final data = productListApiFromJson(response.body);
      final nodata = productListApiFromJson(response.body);
      // print(response.body);
      print(response.body);
      if (response.body.contains('"data":[],')) {
        // var asd ;
        // return "nodata";
        return data;

      } else {
        return data;
      }
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

class OtherProductGet {
  Future<OtherproductList> getOtherProduct() async {
    var response;

    String token = await storage.read(key: 'namatoken');
    try {
      response = await http.get('http://coperationv2.herokuapp.com/api/barang-penjual',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal Ngambil Product");
        print("Ini token read ngab $token");
        return null;
      }

      final data = otherproductListFromJson(response.body);
      print(response.body);
      print("Sukses ngambil Product ngab");
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}
