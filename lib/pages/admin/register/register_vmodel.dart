part of 'register.dart';

String token;
final storage = new FlutterSecureStorage();

// Future registerMember(String name, String email, String password,
//     String c_password, String role, File profile) async {
//   String token = await storage.read(key: 'namatoken');
//   var fileContent = profile.readAsBytesSync();
//   var fileContentBase64 = base64.encode(fileContent);
//   try {
//     var data = {
//       "name": name,
//       "email": email,
//       "password": password,
//       "c_password": c_password,
//       "role": role,
//       "image": fileContentBase64
//     };

//     var hasil = await http.post(
//         'http://coperationv2.herokuapp.com/api/register',
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

Future registerMember(String name, String email, String password, String c_password, String role, File image) async {
  String token = await storage.read(key: 'namatoken');
  Response response;
  Dio dio = new Dio();
  String fileName = image.path.split('/').last;
  // print(fileName);
  FormData formData = new FormData.fromMap({
    "name": name,
    "email": email,
    "password": password,
    "c_password": c_password,
    "role": role,
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  });
  
  dio.options.headers["Authorization"] = "Bearer $token";
  try {
    response = await dio.post("http://coperationv2.herokuapp.com/api/register",
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
