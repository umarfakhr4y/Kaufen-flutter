part of "auth.dart";

DataLogin data;

class UserViewModel {
  Future<DataLogin> getUser() async {
    var response;
    String token = await storage.read(key: 'namatoken');

    try {
      response = await http.get(
          'http://coperationv2.herokuapp.com/api/user/detail',
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        print("Gagal login");
        return null;
      }

      data = dataLoginFromJson(response.body.toString());
      print("Sukses ngambil data ngab");
      return data;
    } catch (e) {
      print("Error pada catch $e");
    }
  }
}

Future<List> getdataprofilee(String name) async {
  String token = await storage.read(key: 'namatoken');
  try {
    http.Response hasil = await http.get(
        "http://coperationv2.herokuapp.com/api/data/${name}",
        headers: {'Authorization': 'Bearer $token'});

    if (hasil.statusCode == 200) {
      // print("Sukses menampilkan Single data");
      final data = dataProfileFromJson(hasil.body);
      // List<dynamic> data = json.decode(hasil.body);
      print("Sukses ngambil data browww");

      print(data);
      return data;
      // return data2;

    } else {
      print("gagal browwww");
      return null;
    }
  } catch (e) {
    print("Error pada catch $e");
  }
}
