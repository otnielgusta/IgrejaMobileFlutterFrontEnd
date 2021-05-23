import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/deleta_entrada_state.dart';
import 'package:flutterigreja/repository/editar_entrada_repository.dart';

class DeletaEntradaController {
  final stateNotifier =
      ValueNotifier<DeletaEntradaState>(DeletaEntradaState.empty);

  set state(DeletaEntradaState state) => stateNotifier.value = state;
  DeletaEntradaState get state => stateNotifier.value;

  final repository = EditarEntradaRepository();
  int status;

  void deletaEntrada({int id}) async {
    this.state = DeletaEntradaState.loading;
    this.status = await repository.deletaEntrada(id: id);
    if (this.status == 204) {
      this.state = DeletaEntradaState.success;
    } else {
      this.state = DeletaEntradaState.error;
    }
  }
}
