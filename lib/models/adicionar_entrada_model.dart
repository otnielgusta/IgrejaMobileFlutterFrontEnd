class AdicionarEntradaModel {
  int idDescricaoEntrada;
  String dataEntrada;
  double valorEntrada;

  AdicionarEntradaModel(
      {this.idDescricaoEntrada, this.dataEntrada, this.valorEntrada});

  AdicionarEntradaModel.fromJson(Map<String, dynamic> json) {
    idDescricaoEntrada = json['id_descricao_entrada'];
    dataEntrada = json['data_entrada'];
    valorEntrada = json['valor_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_descricao_entrada'] = this.idDescricaoEntrada;
    data['data_entrada'] = this.dataEntrada;
    data['valor_entrada'] = this.valorEntrada;
    return data;
  }
}
