import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/relatorio_anual_controller.dart';
import 'package:flutterigreja/pages/Relatorios/relatorio_anual_result.dart';
import 'package:flutterigreja/repository/relatorio_anual_repository.dart';

void main() {
  test("description", () async {
    final controller = RelatorioAnualController();
    await controller.getRelatorioAnual(ano: 2019);
    controller.relatorio.saidas.forEach((element) {
      print(element.nomeDescricaoSaida.toString());
    });

/*
    final repository = RelatorioAnualRepository();

    final response = await repository.getRelatorioAnual(ano: 2019);

    response.saidas.forEach((element) {
      print(element.nomeDescricaoSaida.toString());
    });
    */
  });
}
