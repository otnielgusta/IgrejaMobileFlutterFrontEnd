import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/models/editar_entrada_dados_model.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

void main() {
  test("description", () async {
    final repository = EditarEntradaRepository();
    EditarEntradaDadosModel dados = EditarEntradaDadosModel(
        dataEntrada: "2021-07-15",
        idDescricaoEntrada: 3,
        idEntrada: 1604,
        valorEntrada: 500);
    final response = await repository.setEditarEntada(entradaEditar: dados);
    print(response.toString());
  });
}
