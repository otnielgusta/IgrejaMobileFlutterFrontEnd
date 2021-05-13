import 'dart:convert';

class Mes {
  String nomeMes;
  int numeroMes;

  Mes({this.nomeMes, this.numeroMes});

  Map<String, dynamic> toMap() {
    return {
      'nomeMes': nomeMes,
      'numeroMes': numeroMes,
    };
  }

  factory Mes.fromMap(Map<String, dynamic> map) {
    return Mes(
      nomeMes: map['nomeMes'],
      numeroMes: map['numeroMes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mes.fromJson(String source) => Mes.fromMap(json.decode(source));
}
