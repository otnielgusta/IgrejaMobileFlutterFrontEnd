class Ano {
  int ano;

  Ano({this.ano});

  Ano.fromJson(Map<String, dynamic> json) {
    ano = json['anos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anos'] = this.ano;
    return data;
  }
}
