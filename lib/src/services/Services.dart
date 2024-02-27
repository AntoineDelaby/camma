import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {

  static Future<http.Response> postRequest(String endpoint, Object body) {
    return http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }
}