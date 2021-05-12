import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/adicionar_entrada_controller.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/repository/adicionar_entrada_repository.dart';

void main() {
  test("tem que enviar", () async {
    /*
    final controller = AdicionarEntradaController();
    AdicionarEntradaModel entrada = new AdicionarEntradaModel(
      dataEntrada: "2021-05-11",
      idDescricaoEntrada: 4,
      valorEntrada: 111.98,
    );
    await controller.setAdicionarEntrada(entradaModel: entrada);

    print("no final" + controller.result.toString());

    */
    final repository = AdicionarEntradaRepository();
    AdicionarEntradaModel entrada = new AdicionarEntradaModel(
      dataEntrada: "2021-05-11",
      idDescricaoEntrada: 4,
      valorEntrada: 111.98,
    );
    await repository.setAdiconarEntrada(entradaModel: entrada);
  });
}
