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
// MemberList data;

Future getMemberAdmin() async {
  var response;

  String token = await storage.read(key: 'namatoken');
  try {
    response = await http.get(
        'http://coperationv2.herokuapp.com/api/user/admin',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      print("Gagal Ngambil Member");
      print(response.statusCode);
      return null;
    }

    final data = memberListmodelFromJson(response.body);
    // print(response.body.toString());
    // print(response.body);
    print("Sukses ngambil data member ngab");
    return data;
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future getMemberPenjual() async {
  var response;

  String token = await storage.read(key: 'namatoken');
  try {
    response = await http.get(
        'http://coperationv2.herokuapp.com/api/user/penjual',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      print("Gagal Ngambil Member");
      print("Ini token read ngab $token");
      return null;
    }

    final data = memberListmodelFromJson(response.body);
    // print(response.body.toString());
    // print(response.body);
    print("Sukses ngambil data member ngab");
    return data;
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future getMemberAnggota() async {
  var response;

  String token = await storage.read(key: 'namatoken');
  try {
    response = await http.get(
        'http://coperationv2.herokuapp.com/api/user/anggota',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != 200) {
      print("Gagal Ngambil Member");
      print("Ini token read ngab $token");
      return null;
    }

    final data = memberListmodelFromJson(response.body);
    // print(response.body.toString());
    // print(response.body);
    print("Sukses ngambil data member ngab");
    return data;
  } catch (e) {
    print("Error pada catch $e");
  }
}

Future deleteUser(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    // print(data);

    var hasil = await http.delete(
      "https://coperationv2.herokuapp.com/api/user/delete/${id}",
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

Future makeMemberData(String name, String alamat, String no_telp, DateTime tanggalLahir, int user_id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {
      "name": name,
      "alamat": alamat,
      "no_telp": no_telp,
      "tanggal_lahir": tanggalLahir.toString(),
      "user_id": user_id.toString(),
    };
    print(data);

    var hasil = await http.post("https://coperationv2.herokuapp.com/api/data",
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



Future<List>getSingleMemberUser(String name) async {
  String token = await storage.read(key: 'namatoken');
  try {
      http.Response hasil = await http.get(
          "http://coperationv2.herokuapp.com/api/data/${name}",
          headers: {'Authorization': 'Bearer $token'});

      if (hasil.statusCode == 200) {
        // print("Sukses menampilkan Single data");
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



class GetSingleTest {
  Future getSingleMemberUserTest() async {
    String token = await storage.read(key: 'namatoken');
    try {
      http.Response hasil = await http.get(
          "http://coperationv2.herokuapp.com/api/data/umar",
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
}
