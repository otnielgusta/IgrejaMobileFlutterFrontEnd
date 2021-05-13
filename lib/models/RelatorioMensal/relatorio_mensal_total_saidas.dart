class Totalsaidas {
  String somaTotalSaida;

  Totalsaidas({this.somaTotalSaida});

  Totalsaidas.fromJson(Map<String, dynamic> json) {
    somaTotalSaida = json['soma_total_saida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soma_total_saida'] = this.somaTotalSaida;
    return data;
  }
}
