import 'dart:convert';

import 'package:end_project/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future makeLoans(String total, String kembali, int user_id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"data_id": user_id.toString(), "total": total, "return": kembali, "user_id": user_id.toString()};
    print(data);

    var hasil = await http.post("http://coperationv2.herokuapp.com/api/pinjam",
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

Future editLoans(String total, String kembali, int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"total": total, "return": kembali};
    print(data);

    var hasil =
        await http.put("http://coperationv2.herokuapp.com/api/pinjam/${id}",
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

Future makeDeposit(String total, int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"data_id": id.toString(), "total": total, "user_id": id.toString()};
    print(data);

    var hasil = await http.post("http://coperationv2.herokuapp.com/api/nabung",
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

Future editDeposit(String total, int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"total": total};
    print(data);

    var hasil =
        await http.put("http://coperationv2.herokuapp.com/api/nabung/${id}",
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

// Future makeBarang(String name, String name_barang, String stock, String jenis, String harga, int user_id) async {
//   String token = await storage.read(key: 'namatoken');
//   try {
//     var data = {
//       "user_id": user_id.toString(),
//       "name": name,
//       "name_barang": name_barang,
//       "stock": stock,
//       "jenis": jenis,
//       "harga": harga,
//     };
//     print(data);

//     var hasil =
//         await http.post("http://coperationv2.herokuapp.com/api/barang-penjual",
//             headers: {
//               'Authorization': 'Bearer $token',
//             },
//             body: (data));
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
