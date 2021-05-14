import 'package:dio/dio.dart';
import 'package:flutterigreja/models/relatorio_anual_model.dart';
import 'package:flutterigreja/url.dart';

class RelatorioAnualRepository {
  Future<RelatorioAnualModel> getRelatorioAnual({int ano}) async {
    var dio = Dio();

    Map<String, dynamic> request = {"ano": ano};

    final response = await dio.get("${UrlIgreja.url}/relatorio-anual-result",
        queryParameters: request);

    final relatorio = RelatorioAnualModel.fromJson(response.data);

    return relatorio;
  }
}
