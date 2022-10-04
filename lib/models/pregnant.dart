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
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String cui;
  String nombres;
  String apellidos;
  String direccion;
  DateTime fechaDeNacimiento;
  DateTime ultimaRegla;
  String peso;
  String altura;
  String idUser;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Pregnant.fromJson(Map<String, dynamic> json) => Pregnant(
        cui: json["cui"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        direccion: json["direccion"],
        fechaDeNacimiento: DateTime.parse(json["fecha_de_nacimiento"]),
        ultimaRegla: DateTime.parse(json["ultima_regla"]),
        peso: json["peso"],
        altura: json["altura"],
        idUser: json["id_user"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cui": cui,
        "nombres": nombres,
        "apellidos": apellidos,
        "direccion": direccion,
        "fecha_de_nacimiento":
            "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
        "ultima_regla":
            "${ultimaRegla.year.toString().padLeft(4, '0')}-${ultimaRegla.month.toString().padLeft(2, '0')}-${ultimaRegla.day.toString().padLeft(2, '0')}",
        "peso": peso,
        "altura": altura,
        "id_user": idUser,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
