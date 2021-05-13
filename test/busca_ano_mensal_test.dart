import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/busca_ano_mensal_controller.dart';
import 'package:flutterigreja/repository/busca_anos_mensal_repository.dart';

void main() {
  test("busca dos anos", () async {
    final controller = BuscaAnoMensalController();
    await controller.getAnosMensal();
    controller.anos.anos.forEach((element) {
      print(element.ano.toString());
    });

/*
    final repository = BuscaAnosMensalRepository();
    final result = await repository.getAnoMensal();
    result.ano.forEach((element) {
      print(element.anos.toString());
    });
    */
  });
}
