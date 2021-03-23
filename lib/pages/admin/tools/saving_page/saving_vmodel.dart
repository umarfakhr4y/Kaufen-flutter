



import 'package:end_project/auth/auth.dart';
import 'package:http/http.dart' as http;

import 'model/savingmodeladmin.dart';

Future getSavingss() async {
  String token = await storage.read(key: 'namatoken');
  try {
    http.Response hasil = await http.get(
        "http://coperationv2.herokuapp.com/api/nabung-req/list",
        headers: {'Authorization': 'Bearer $token'});

    if (hasil.statusCode == 200) {
      // print("Sukses menampilkan Single data");
      final data = adminsavingsFromJson(hasil.body);
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