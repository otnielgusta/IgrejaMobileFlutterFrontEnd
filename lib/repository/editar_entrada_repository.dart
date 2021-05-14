import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/editarEntrada/editar_entrada_model.dart';
import 'package:flutterigreja/url.dart';

class EditarEntradaRepository {
  Future<EditarEntradaModel> getEditarEntrada(
      {int idDescricaoEntrada, int valorEntrada, String dataEntrada}) async {
    var dio = Dio();
    Map<String, dynamic> request = {};
    if (idDescricaoEntrada != null && idDescricaoEntrada != -1) {
      request = {"id_descricao_entrada": idDescricaoEntrada};
    } else if ((valorEntrada != null) && (valorEntrada != 0)) {
      request = {"valor_entrada": valorEntrada};
    } else if (dataEntrada != null && dataEntrada != "dataEntrada") {
      request = {"data_entrada": dataEntrada};
    }

    final response = await dio.get("${UrlIgreja.url}/editar-entradas",
        queryParameters: request);
    final entradas = EditarEntradaModel.fromJson(response.data);
    return entradas;
  }
}