import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/adicionar_saida_state.dart';
import 'package:flutterigreja/models/adicionar_saida_model.dart';
import 'package:flutterigreja/repository/adicionar_saida_repository.dart';

class AdicionarSaidasController {
  final stateNotifier =
      ValueNotifier<AdicionarSaidaState>(AdicionarSaidaState.empty);

  set state(AdicionarSaidaState state) => stateNotifier.value = state;
  AdicionarSaidaState get state => stateNotifier.value;

  final repository = AdicionarSaidaRepository();
  int status;

  void setSaidas({@required AdicionarSaidaModel saida}) async {
    state = AdicionarSaidaState.loading;
    this.status = await repository.setSaida(saida);
    if (this.status == 201) {
      state = AdicionarSaidaState.success;
    } else {
      state = AdicionarSaidaState.error;
    }
  }
}
