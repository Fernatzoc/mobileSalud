class Pregnant {
  Pregnant({
    required this.cui,
    required this.nombres,
    required this.apellidos,
    required this.direccion,
    required this.fechaDeNacimiento,
    required this.ultimaRegla,
    required this.peso,
    required this.altura,
    required this.idUser,
    this.userName,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String cui;
  String nombres;
  String apellidos;
  String direccion;
  String fechaDeNacimiento;
  String ultimaRegla;
  String peso;
  String altura;
  String? userName;
  String idUser;
  String updatedAt;
  String createdAt;
  int id;

  factory Pregnant.fromJson(Map<String, dynamic> json) => Pregnant(
        cui: json["cui"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        direccion: json["direccion"],
        fechaDeNacimiento: json["fecha_de_nacimiento"],
        ultimaRegla: json["ultima_regla"],
        peso: json["peso"],
        altura: json["altura"],
        idUser: json["id_user"],
        userName: json["user_name"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cui": cui,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "fecha_de_nacimiento": fechaDeNacimiento,
        "ultima_regla": ultimaRegla,
        "peso": peso,
        "altura": altura,
        "id_user": idUser,
        "user_name": userName,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
