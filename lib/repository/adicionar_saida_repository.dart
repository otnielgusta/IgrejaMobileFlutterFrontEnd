import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/models/adicionar_saida_model.dart';
import 'package:flutterigreja/url.dart';

class AdicionarSaidaRepository {
  Future<int> setSaida(AdicionarSaidaModel saida) async {
    var dio = Dio();
    final request = saida.toJson();
    final response =
        await dio.post("${UrlIgreja.url}/adicionar-saidas", data: request);
    int status = response.statusCode;

    return status;
  }
}
