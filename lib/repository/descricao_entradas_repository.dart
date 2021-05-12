import 'package:dio/dio.dart';

import 'package:flutterigreja/models/descricao_adicionar_entradas_model.dart';
import 'package:flutterigreja/url.dart';

class DescricaoEntradaRepository {
  Future<DescricaoEntradaModel> getDescricaoEntrada() async {
    var dio = Dio();

    final response = await dio.get("${UrlIgreja.url}/adicionar-entradas");

    final descricao = DescricaoEntradaModel.fromJson(response.data);
    return descricao;
  }
}
