import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/url.dart';

class AdicionarEntradaRepository {
  Future<int> setAdiconarEntrada({
    AdicionarEntradaModel entradaModel,
  }) async {
    var dio = Dio();
    final request = entradaModel.toJson();
    final response =
        await dio.post('${UrlIgreja.url}/adicionar-entradas', data: request);

    int status = response.statusCode;

    return status;
  }
}
