import 'package:campma/src/services/Endpoints.dart';
import 'package:campma/src/services/Services.dart';
import 'package:http/http.dart' as http;

class AuthentificationServices {

  static Future<http.Response> login(String email, String password) {
    return Services.postRequest(Endpoints.login, {'email':email, 'password': password});
  }

  static Future<http.Response> register(String email, String password) {
    return Services.postRequest(Endpoints.register, {'email':email, 'password': password});
  }
}