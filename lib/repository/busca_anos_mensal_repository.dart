import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/models/RelatorioMensal/busca_ano_mensal_model.dart';
import 'package:flutterigreja/url.dart';

class BuscaAnosMensalRepository {
  Future<BuscaAnoMensalModel> getAnoMensal() async {
    var dio = Dio();

    final response = await dio.get("${UrlIgreja.url}/relatorio-mensal");
    final result = BuscaAnoMensalModel.fromJson(response.data);

    return result;
  }
}
