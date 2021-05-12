import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/descricao_entrada_controller.dart';
import 'package:flutterigreja/models/descricao_adicionar_entradas_model.dart';
import 'package:flutterigreja/repository/descricao_entradas_repository.dart';

void main() {
  test("Tem que dar certo", () async {
    final controller = DescricaoEntradaController();
    await controller.getDescricaoEntrada();

    controller.descricaoEntradaModel.descricaoEntrada.forEach((element) {
      print(element.idDescricaoEntrada);
      print(element.nomeDescricaoEntrada);
    });
  });
}
