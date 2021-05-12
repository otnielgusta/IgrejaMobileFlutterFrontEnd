import 'package:dio/dio.dart';
import 'package:flutterigreja/models/descricao_saida_model.dart';
import 'package:flutterigreja/url.dart';

class DescricaoSaidasRepository {
  Future<DescricaoSaidaModel> getDescricaoSaida() async {
    var dio = Dio();

    final response = await dio.get("${UrlIgreja.url}/adicionar-saidas");
    final descricao = DescricaoSaidaModel.fromJson(response.data);
    return descricao;
  }
}
