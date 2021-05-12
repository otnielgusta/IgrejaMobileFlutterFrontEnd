import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/descricao_saida_controller.dart';
import 'package:flutterigreja/models/descricao_saida_model.dart';
import 'package:flutterigreja/repository/descricao_saidas_repository.dart';

void main() {
  test("Retornar as descrições", () async {
    final controller = DescricaoSaidaController();
    await controller.getDescricaoSaida();

    controller.descricaoSaida.descricaoSaida.forEach((element) {
      print(
          "${element.idDescricaoSaida.toString()}: ${element.nomeDescricaoSaida.toString()}");
    });
  });
}
