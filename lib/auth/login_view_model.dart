part of 'auth.dart';

String token;
final storage = new FlutterSecureStorage();

Future loginUser(String email, String password) async {
  String tokenRead = await storage.read(key: 'namatoken');

  try {
    var data = {"email": email, "password": password};
    print(data);

    var url = "https://coperationv2.herokuapp.com/api/login";
    var hasil = await http.post(url, body: (data));

    if (hasil.statusCode == 403) {
      print("Silahkan Verifikasi");
      print(hasil.statusCode);
      return false;
    } else {
      if (hasil.statusCode != 200) {
        print("Gagal login");
        print(hasil.statusCode);
        return null;
      }
      print("Sukses login");
      //INI BUAT TOKEN//
      token = (tokenFromJson(hasil.body)).success.token;
      await storage.write(key: 'namatoken', value: token);
      //////

      if (token != null) {
        print("token berhasil disimpan");
      }

      ///
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenauto', token);
      return true;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}

class GetRoleVModel {
  Future getRole() async {
    var response;
    String token = await storage.read(key: 'namatoken');

    try {
      response = await http.get(
          'http://coperationv2.herokuapp.com/api/user/detail',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal login");
        print(response.statusCode);
        return null;
      }
      data = dataLoginFromJson(response.body.toString());
      print(response.body.toString());
      // if (response.body.toString().contains('email_verified_at":null')) {
      //   print("ini admin di abis get role");
      //   return "verfiks";
      // } else
      if (response.body.toString().contains('"role":["admin"]')) {
        print("ini admin di abis get role");
        return "admin";
      } else if (response.body.toString().contains('"role":["penjual"]')) {
        print("ini penjual di abis get role");
        return "penjual";
      } else if (response.body.toString().contains('"role":["anggota"]')) {
        print("ini penjual di abis get role");
        return "anggota";
      }
      // }
      // print(token);
      print("Sukses ngambil data ngab");
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

Future logOut() async {
  token = await storage.read(key: 'namatoken');
  try {
    var hasil = await http.post('http://coperationv2.herokuapp.com/api/logout',
        headers: {'Authorization': 'Bearer $token'});
    print('masuk; response code: ${hasil.statusCode}');
    if (hasil.statusCode == 200) {
      await storage.delete(key: 'namatoken');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenauto', null);
    }
    return "logout";
  } catch (e) {
    print(e);
  }
}

Future clearToken() async {
  token = await storage.read(key: 'namatoken');

  await storage.delete(key: 'namatoken');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('tokenauto', null);

  if (token == null) {
    print("token 1 hilang");
  }
}

Future selfDelete() async {
  token = await storage.read(key: 'namatoken');
  try {
    var hasil = await http.delete(
        'http://coperationv2.herokuapp.com/api/user/delete',
        headers: {'Authorization': 'Bearer $token'});
    print('masuk; response code: ${hasil.statusCode}');
    if (hasil.statusCode == 200) {
      await storage.delete(key: 'namatoken');
    }
    return "success";
  } catch (e) {
    print(e);
  }
}

Future forgotPW(String email) async {
  try {
    var data = {"email": email};
    print(data);

    var hasil = await http.post(
        'http://coperationv2.herokuapp.com/api/password/email',
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
    //INI BUAT TOKEN//

  } catch (e) {
    print("Error pada catch $e");
  }
}
