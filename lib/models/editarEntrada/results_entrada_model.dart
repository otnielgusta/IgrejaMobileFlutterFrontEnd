class ResultsEntrada {
  int idEntrada;
  int idDescricaoEntrada;
  String dataEntrada;
  String valorEntrada;
  String nomeDescricaoEntrada;

  ResultsEntrada(
      {this.idEntrada,
      this.idDescricaoEntrada,
      this.dataEntrada,
      this.valorEntrada,
      this.nomeDescricaoEntrada});

  ResultsEntrada.fromJson(Map<String, dynamic> json) {
    idEntrada = json['id_entrada'];
    idDescricaoEntrada = json['id_descricao_entrada'];
    dataEntrada = json['data_entrada'];
    valorEntrada = json['valor_entrada'];
    nomeDescricaoEntrada = json['nome_descricao_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_entrada'] = this.idEntrada;
    data['id_descricao_entrada'] = this.idDescricaoEntrada;
    data['data_entrada'] = this.dataEntrada;
    data['valor_entrada'] = this.valorEntrada;
    data['nome_descricao_entrada'] = this.nomeDescricaoEntrada;
    return data;
  }
}
