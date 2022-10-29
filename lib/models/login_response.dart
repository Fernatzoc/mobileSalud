// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.token,
    required this.id,
  });

  String status;
  String token;
  String id;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        token: json["token"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {"status": status, "token": token, "id": id};
}
