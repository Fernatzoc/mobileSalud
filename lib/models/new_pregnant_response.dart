import 'dart:convert';

import 'pregnant.dart';

NewPregnantResponse newPregnantResponseFromJson(String str) =>
    NewPregnantResponse.fromJson(json.decode(str));

String newPregnantResponseToJson(NewPregnantResponse data) =>
    json.encode(data.toJson());

class NewPregnantResponse {
  NewPregnantResponse({
    required this.status,
    required this.pregnant,
  });

  String status;
  Pregnant pregnant;

  factory NewPregnantResponse.fromJson(Map<String, dynamic> json) =>
      NewPregnantResponse(
        status: json["status"],
        pregnant: Pregnant.fromJson(json["pregnant"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pregnant": pregnant.toJson(),
      };
}
