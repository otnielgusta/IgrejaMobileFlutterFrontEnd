class Saidas {
  String nomeDescricaoSaida;
  String somaSaida;

  Saidas({this.nomeDescricaoSaida, this.somaSaida});

  Saidas.fromJson(Map<String, dynamic> json) {
    nomeDescricaoSaida = json['nome_descricao_saida'];
    somaSaida = json['soma_saida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome_descricao_saida'] = this.nomeDescricaoSaida;
    data['soma_saida'] = this.somaSaida;
    return data;
  }
}
