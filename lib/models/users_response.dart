import 'dart:convert';

import 'package:mobile_salud/models/index.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    required this.data,
  });

  List<User> data;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
