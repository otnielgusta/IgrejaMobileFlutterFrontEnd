class Entradas {
  String nomeDescricaoEntrada;
  String somaEntrada;

  Entradas({this.nomeDescricaoEntrada, this.somaEntrada});

  Entradas.fromJson(Map<String, dynamic> json) {
    nomeDescricaoEntrada = json['nome_descricao_entrada'];
    somaEntrada = json['soma_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome_descricao_entrada'] = this.nomeDescricaoEntrada;
    data['soma_entrada'] = this.somaEntrada;
    return data;
  }
}
