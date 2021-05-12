class DescricaoSaidaItemsModel {
  int idDescricaoSaida;
  String nomeDescricaoSaida;

  DescricaoSaidaItemsModel({this.idDescricaoSaida, this.nomeDescricaoSaida});

  DescricaoSaidaItemsModel.fromJson(Map<String, dynamic> json) {
    idDescricaoSaida = json['id_descricao_saida'];
    nomeDescricaoSaida = json['nome_descricao_saida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_descricao_saida'] = this.idDescricaoSaida;
    data['nome_descricao_saida'] = this.nomeDescricaoSaida;
    return data;
  }
}
