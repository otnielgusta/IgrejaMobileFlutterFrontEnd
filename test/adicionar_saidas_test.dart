import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/adicionar_entrada_controller.dart';
import 'package:flutterigreja/controllers/adicionar_saida_controller.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/adicionar_saida_model.dart';
import 'package:flutterigreja/repository/adicionar_entrada_repository.dart';
import 'package:flutterigreja/repository/adicionar_saida_repository.dart';

void main() {
  test("tem que enviar", () async {
    final controller = AdicionarSaidasController();
    AdicionarSaidaModel saida = new AdicionarSaidaModel(
      dataSaida: "2021-05-11",
      idDescricaoSaida: 4,
      valorSaida: 111.98,
    );
    await controller.setSaidas(saida: saida);
    print(controller.status);

    /*
    final repository = AdicionarSaidaRepository();
    AdicionarSaidaModel entrada = new AdicionarSaidaModel(
      dataSaida: "2021-05-11",
      idDescricaoSaida: 4,
      valorSaida: 111.98,
    );
    final response = await repository.setSaida(entrada);

    print(response);
    */
  });
}
