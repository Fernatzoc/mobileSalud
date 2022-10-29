import 'dart:convert';

import 'package:mobile_salud/models/index.dart';

NewUsersResponse newUsersResponseFromJson(String str) =>
    NewUsersResponse.fromJson(json.decode(str));

String newUsersResponseToJson(NewUsersResponse data) =>
    json.encode(data.toJson());

class NewUsersResponse {
  NewUsersResponse({
    required this.data,
  });

  User data;

  factory NewUsersResponse.fromJson(Map<String, dynamic> json) =>
      NewUsersResponse(
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
