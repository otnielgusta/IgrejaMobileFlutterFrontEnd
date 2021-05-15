import 'dart:convert';

class EditarEntradaDadosModel {
  int idEntrada;
  int idDescricaoEntrada;
  String dataEntrada;
  double valorEntrada;
  EditarEntradaDadosModel({
    this.idEntrada,
    this.idDescricaoEntrada,
    this.dataEntrada,
    this.valorEntrada,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_entrada': idEntrada,
      'id_descricao_entrada': idDescricaoEntrada,
      'data_entrada': dataEntrada,
      'valor_entrada': valorEntrada,
    };
  }

  factory EditarEntradaDadosModel.fromMap(Map<String, dynamic> map) {
    return EditarEntradaDadosModel(
      idEntrada: map['id_entrada'],
      idDescricaoEntrada: map['id_descricao_entrada'],
      dataEntrada: map['data_entrada'],
      valorEntrada: map['valor_entrada'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditarEntradaDadosModel.fromJson(String source) =>
      EditarEntradaDadosModel.fromMap(json.decode(source));
}
