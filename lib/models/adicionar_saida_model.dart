class AdicionarSaidaModel {
  int idDescricaoSaida;
  String dataSaida;
  double valorSaida;

  AdicionarSaidaModel({this.idDescricaoSaida, this.dataSaida, this.valorSaida});

  AdicionarSaidaModel.fromJson(Map<String, dynamic> json) {
    idDescricaoSaida = json['id_descricao_saida'];
    dataSaida = json['data_saida'];
    valorSaida = json['valor_saida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_descricao_saida'] = this.idDescricaoSaida;
    data['data_saida'] = this.dataSaida;
    data['valor_saida'] = this.valorSaida;
    return data;
  }
}
