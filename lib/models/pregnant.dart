class Pregnant {
  Pregnant({
    required this.cui,
    required this.nombres,
    required this.apellidos,
    required this.direccion,
    required this.fechaDeNacimiento,
    required this.ultimaRegla,
    required this.tipoDeExamen,
    required this.peso,
    required this.altura,
    required this.cmb,
    required this.idUser,
    this.userName,
    this.estado,
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
  String tipoDeExamen;
  String peso;
  String altura;
  String cmb;
  String? userName;
  String idUser;
  int? estado;
  String updatedAt;
  String createdAt;
  int id;

  factory Pregnant.fromJson(Map<String, dynamic> json) => Pregnant(
        cui: json["cui"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        direccion: json["direccion"],
        fechaDeNacimiento: json["fecha_de_nacimiento"],
        tipoDeExamen: json["tipo_de_examen"],
        ultimaRegla: json["ultima_regla"],
        peso: json["peso"],
        altura: json["altura"],
        cmb: json["cmb"],
        idUser: json["id_user"],
        userName: json["user_name"],
        estado: json["estado"],
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
        "tipo_de_examen": tipoDeExamen,
        "peso": peso,
        "altura": altura,
        "cmb": cmb,
        "id_user": idUser,
        "user_name": userName,
        "estado": estado,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
