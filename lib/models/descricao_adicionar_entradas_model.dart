import 'descricao_entrada_model.dart';

class DescricaoEntradaModel {
  List<DescricaoEntrada> descricaoEntrada;

  DescricaoEntradaModel({this.descricaoEntrada});

  DescricaoEntradaModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      descricaoEntrada = new List<DescricaoEntrada>();
      json['response'].forEach((v) {
        descricaoEntrada.add(new DescricaoEntrada.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.descricaoEntrada != null) {
      data['response'] = this.descricaoEntrada.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
