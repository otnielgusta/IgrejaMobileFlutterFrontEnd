import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_model.dart';
import 'package:flutterigreja/url.dart';

class RelatorioMensalRepository {
  Future<RelatorioMensalModel> getRelatorioMensal(
      {@required int mes, @required int ano}) async {
    var dio = Dio();
    Map<String, dynamic> request = {'mes': mes, 'ano': ano};

    final response = await dio.get("${UrlIgreja.url}/relatorio-mensal-result",
        queryParameters: request);

    final relatorioMensal = RelatorioMensalModel.fromJson(response.data);

    return relatorioMensal;
  }
}
