import 'dart:convert';

import 'index.dart';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    this.allUsers,
  });

  AllUsers? allUsers;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        allUsers: AllUsers.fromJson(json["allUsers"]),
      );

  Map<String, dynamic> toJson() => {
        "allUsers": allUsers?.toJson(),
      };
}

class AllUsers {
  AllUsers({
    this.currentPage,
    required this.data,
    this.total,
  });

  int? currentPage;
  List<User> data;
  int? total;

  factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
        currentPage: json["current_page"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<User>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}
