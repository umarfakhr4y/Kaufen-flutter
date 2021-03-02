import 'package:end_project/pages/admin/tools/model/memberListSingle.dart';
import 'package:http/http.dart' as http;
import 'auth/auth.dart';

Future profileEdit(String name, String email) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {
      "name": name,
      "email": email,
    };
    print(data);

    var hasil = await http.put(
        "http://coperationv2.herokuapp.com/api/user/update-profile",
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: (data));
    if (hasil.statusCode == 200) {
      print("Sukses mengubah profile");
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

Future editData(String namelama, String namebaru, String alamat, String notelp, String tgl_lahir) async {
  String token = await storage.read(key: 'namatoken');
  try {

    var data = {
      "name": namebaru,
      "alamat": alamat,
      "no_telp": notelp,
      "tanggal_lahir": tgl_lahir,
    };
    print(data);

    http.Response hasil = await http.put(
        "http://coperationv2.herokuapp.com/api/data/${namelama}",
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: (data));

    if (hasil.statusCode == 200) {
      print("Sukses mengubah data");
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
