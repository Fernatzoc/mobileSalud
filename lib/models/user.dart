import 'package:mobile_salud/models/index.dart';

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.rol,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.pregnants});

  int? id;
  String? name;
  String? email;
  String? rol;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  List<Pregnant>? pregnants;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        rol: json["rol"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pregnants: List<Pregnant>.from(
            json["pregnants"].map((x) => Pregnant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "rol": rol,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pregnants": List<dynamic>.from(pregnants!.map((x) => x.toJson())),
      };
}
