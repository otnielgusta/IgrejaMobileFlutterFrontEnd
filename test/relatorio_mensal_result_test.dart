import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/relatorio_mensal_controller.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_model.dart';
import 'package:flutterigreja/repository/relatorio_mensal_repository.dart';

void main() {
  test("relatorio mensal", () async {
    final controller = RelatorioMensalController();
    await controller.getRelatorioMensal(ano: 2019, mes: 06);

    controller.relatorioMensalModel.saidas.forEach((element) {
      print(element.nomeDescricaoSaida);
      print(element.somaSaida);
    });

    /*
    final repository = RelatorioMensalRepository();

    final relatorioMensal =
        await repository.getRelatorioMensal(mes: 6, ano: 2019);

    relatorioMensal.saidas.forEach((element) {
      print(element.nomeDescricaoSaida);
      print(element.somaSaida);
    });
    */
  });
}
