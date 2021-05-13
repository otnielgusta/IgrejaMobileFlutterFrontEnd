import 'ano_model.dart';

class BuscaAnoMensalModel {
  List<Ano> anos;

  BuscaAnoMensalModel({this.anos});

  BuscaAnoMensalModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      anos = new List<Ano>();
      json['response'].forEach((v) {
        anos.add(new Ano.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.anos != null) {
      data['response'] = this.anos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
