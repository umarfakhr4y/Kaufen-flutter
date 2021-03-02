import 'package:http/http.dart' as http;
import 'package:end_project/auth/auth.dart';

Future editPassw(String current_pw, String password, String password_confirm) async {
  String token = await storage.read(key: 'namatoken');
  try {
    var data = {"current_password": current_pw, "new_password": password, "new_confirm_password":password_confirm};
    print(data);
    
    var hasil =
          await http.post('http://coperationv2.herokuapp.com/api/change-password',
              body: (data),
              headers: {'Authorization': 'Bearer $token'});
    if (hasil.statusCode == 200) {
      print(hasil.statusCode);
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