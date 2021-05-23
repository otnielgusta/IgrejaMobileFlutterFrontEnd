import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/deleta_entrada_controller.dart';
import 'package:flutterigreja/models/editar_entrada_dados_model.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

void main() {
  test("description", () async {
    final controller = DeletaEntradaController();
    await controller.deletaEntrada(id: 1504);

    print("O status é: " + controller.status.toString());

    /*
    EditarEntradaDadosModel dados = EditarEntradaDadosModel(
        dataEntrada: "2021-07-15",
        idDescricaoEntrada: 3,
        idEntrada: 1604,
        valorEntrada: 500);
    final response = await repository.setEditarEntada(entradaEditar: dados);
    print(response.toString());

    */
  });
}
