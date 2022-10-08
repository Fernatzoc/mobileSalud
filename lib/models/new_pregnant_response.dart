// To parse this JSON data, do
//
//     final newPregnantResponse = newPregnantResponseFromJson(jsonString);

import 'dart:convert';

import 'index.dart';

NewPregnantResponse newPregnantResponseFromJson(String str) =>
    NewPregnantResponse.fromJson(json.decode(str));

String newPregnantResponseToJson(NewPregnantResponse data) =>
    json.encode(data.toJson());

class NewPregnantResponse {
  NewPregnantResponse({
    required this.data,
  });

  Pregnant data;

  factory NewPregnantResponse.fromJson(Map<String, dynamic> json) =>
      NewPregnantResponse(
        data: Pregnant.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
