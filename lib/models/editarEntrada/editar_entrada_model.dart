import 'package:flutterigreja/models/editarEntrada/results_entrada_model.dart';

class EditarEntradaModel {
  List<ResultsEntrada> results;

  EditarEntradaModel({this.results});

  EditarEntradaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<ResultsEntrada>();
      json['results'].forEach((v) {
        results.add(new ResultsEntrada.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
