import 'dart:convert';
import 'package:demo/utils/Const.dart';
import 'package:http/http.dart' as http;
import 'package:demo/models/login_model.dart';


class ApiService{
  Future<SignInResponse> login(SignInRequest loginRequest) async {
    final response = await http.post(
      Uri.parse(Const.SERVER_BASE_URL),
      headers: {"Content-Type": "application/json"},
      body: json.encode(loginRequest.toJson()),
    );


    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the login response
      return SignInResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}