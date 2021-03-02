part of 'koperasi.dart';

String token;
final storage = new FlutterSecureStorage();

// Future addProduct(
//   String name,
//   String jenis,
//   String stock,
//   String harga,
// ) async {
//   String token = await storage.read(key: 'namatoken');
//   try {
//     var data = {"name": name, "jenis": jenis, "stock": stock, "harga": harga};
//     print(data);

//     var hasil = await http.post(
//         'http://coperationv2.herokuapp.com/api/barang-koperasi',
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

Future addProduct(
    String name, String jenis, String stock, String harga, File image) async {
  String token = await storage.read(key: 'namatoken');
  Response response;
  Dio dio = new Dio();
  String fileName = image.path.split('/').last;
  // print(fileName);
  FormData formData = new FormData.fromMap({
    "name": name,
    "jenis": jenis,
    "stock": stock,
    "harga": harga,
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  });

  dio.options.headers["Authorization"] = "Bearer $token";
  try {
    response = await dio.post("http://coperationv2.herokuapp.com/api/barang-koperasi",
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

Future editProduct(
    String name, String jenis, String stock, String harga, int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"name": name, "jenis": jenis, "stock": stock, "harga": harga};
    print(data);

    var hasil = await http.patch(
        'http://coperationv2.herokuapp.com/api/barang-koperasi/${id}',
        body: (data),
        headers: {'Authorization': 'Bearer $token'});
    if (hasil.statusCode == 200) {
      print("Sukses mengubah data");
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

Future deleteProduct(int id) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var hasil = await http.delete(
        'http://coperationv2.herokuapp.com/api/barang-koperasi/${id}',
        headers: {'Authorization': 'Bearer $token'});
    if (hasil.statusCode == 200) {
      print("Sukses Menghapus data");
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
