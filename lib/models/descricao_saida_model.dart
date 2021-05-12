import 'package:flutterigreja/models/descricao_saida_items_model.dart';

class DescricaoSaidaModel {
  List<DescricaoSaidaItemsModel> descricaoSaida;

  DescricaoSaidaModel({this.descricaoSaida});

  DescricaoSaidaModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      descricaoSaida = new List<DescricaoSaidaItemsModel>();
      json['response'].forEach((v) {
        descricaoSaida.add(new DescricaoSaidaItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.descricaoSaida != null) {
      data['response'] = this.descricaoSaida.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
