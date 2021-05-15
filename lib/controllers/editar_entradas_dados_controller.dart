import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/editar_entrada_dados_state.dart';
import 'package:flutterigreja/controllers/states/editar_entrada_state.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/editarEntrada/editar_entrada_model.dart';
import 'package:flutterigreja/models/editar_entrada_dados_model.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

class EditarEntradaController {
  final stateNotifier =
      ValueNotifier<EditarEntradaDadosState>(EditarEntradaDadosState.empty);

  set state(EditarEntradaDadosState state) => stateNotifier.value = state;
  EditarEntradaDadosState get state => stateNotifier.value;

  int statusCode;
  final repository = EditarEntradaRepository();

  void setEditarEntrada({EditarEntradaDadosModel editarDados}) async {
    this.state = EditarEntradaDadosState.loading;
    this.statusCode =
        await repository.setEditarEntada(entradaEditar: editarDados);
  }
}
