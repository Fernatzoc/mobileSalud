import 'dart:convert';

import './index.dart';

PregnantResponse pregnantResponseFromJson(String str) =>
    PregnantResponse.fromJson(json.decode(str));

String pregnantResponseToJson(PregnantResponse data) =>
    json.encode(data.toJson());

class PregnantResponse {
  PregnantResponse({
    this.data,
  });

  List<Pregnant>? data;

  factory PregnantResponse.fromJson(Map<String, dynamic> json) =>
      PregnantResponse(
        data:
            List<Pregnant>.from(json["data"].map((x) => Pregnant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
