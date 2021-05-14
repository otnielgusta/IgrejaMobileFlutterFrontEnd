import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/editar_entrada_state.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/editarEntrada/editar_entrada_model.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

class EditarEntradaController {
  final stateNotifier =
      ValueNotifier<EditarEntradaState>(EditarEntradaState.empty);

  set state(EditarEntradaState state) => stateNotifier.value = state;
  EditarEntradaState get state => stateNotifier.value;

  EditarEntradaModel editarEntrada;
  final repository = EditarEntradaRepository();

  void getEditarEntrada(
      {int idDescricaoEntrada, int valorEntrada, String dataEntrada}) async {
    this.state = EditarEntradaState.loading;
    this.editarEntrada = await repository.getEditarEntrada(
        dataEntrada: dataEntrada,
        idDescricaoEntrada: idDescricaoEntrada,
        valorEntrada: valorEntrada);

    this.state = EditarEntradaState.success;
  }
}
