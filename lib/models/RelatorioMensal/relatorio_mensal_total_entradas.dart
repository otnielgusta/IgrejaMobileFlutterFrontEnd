class Totalentradas {
  String somaTotalEntrada;

  Totalentradas({this.somaTotalEntrada});

  Totalentradas.fromJson(Map<String, dynamic> json) {
    somaTotalEntrada = json['soma_total_entrada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soma_total_entrada'] = this.somaTotalEntrada;
    return data;
  }
}
