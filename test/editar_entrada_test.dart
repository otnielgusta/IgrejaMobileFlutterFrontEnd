import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/editar_entradas_controller.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

void main() {
  test("description", () async {
    final controller = EditarEntradaController();
    AdicionarEntradaModel valores = AdicionarEntradaModel(
        valorEntrada: null, dataEntrada: null, idDescricaoEntrada: 5);
    await controller.getEditarEntrada(
        dataEntrada: null, idDescricaoEntrada: null, valorEntrada: 20);

    controller.editarEntrada.results.forEach((element) {
      print(element.dataEntrada.toString());
      print(element.idDescricaoEntrada.toString());
      print(element.idEntrada.toString());
      print(element.nomeDescricaoEntrada.toString());
      print(element.valorEntrada.toString());
      print("--------------------------------------");
    });

/*
    final repository = EditarEntradaRepository();
    AdicionarEntradaModel valores = AdicionarEntradaModel(
        idDescricaoEntrada: 2, dataEntrada: null, valorEntrada: null);
    final response = await repository.getEditarEntrada(valores: valores);

    response.results.forEach((element) {
      print(element.dataEntrada.toString());
      print(element.idDescricaoEntrada.toString());
      print(element.idEntrada.toString());
      print(element.nomeDescricaoEntrada.toString());
      print(element.valorEntrada.toString());
      print("--------------------------------------");
    });
    */
  });
}
