class DescricaoEntrada {
  int idDescricaoEntrada;
  String nomeDescricaoEntrada;

  DescricaoEntrada({this.idDescricaoEntrada, this.nomeDescricaoEntrada});

  int get hashCode => idDescricaoEntrada.hashCode;

  bool operator ==(Object other) =>
      other is DescricaoEntrada &&
      other.idDescricaoEntrada == idDescricaoEntrada;

  DescricaoEntrada.fromJson(Map<String, dynamic> json) {
    idDescricaoEntrada = json['id_descricao_entrada'];
    nomeDescricaoEntrada = json['nome_descricao_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_descricao_entrada'] = this.idDescricaoEntrada;
    data['nome_descricao_entrada'] = this.nomeDescricaoEntrada;
    return data;
  }
}
