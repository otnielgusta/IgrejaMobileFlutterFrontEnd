import 'package:flutterigreja/models/RelatorioMensal/mes.dart';

class Meses {
  List<Mes> mes;

  Meses({this.mes});

  Meses.fromJson(Map<String, dynamic> json) {
    if (json['mes'] != null) {
      mes = new List<Mes>();
      json['mes'].forEach((v) {
        mes.add(new Mes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mes != null) {
      data['mes'] = this.mes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
