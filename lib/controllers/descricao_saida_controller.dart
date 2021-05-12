import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/descricao_saida_state.dart';
import 'package:flutterigreja/models/descricao_saida_model.dart';
import 'package:flutterigreja/repository/descricao_entradas_repository.dart';
import 'package:flutterigreja/repository/descricao_saidas_repository.dart';

class DescricaoSaidaController {
  final stateNotifier =
      ValueNotifier<DescricaoSaidaState>(DescricaoSaidaState.empty);

  set state(DescricaoSaidaState state) => stateNotifier.value = state;
  DescricaoSaidaState get state => stateNotifier.value;

  DescricaoSaidaModel descricaoSaida;
  final repository = DescricaoSaidasRepository();

  void getDescricaoSaida() async {
    state = DescricaoSaidaState.loading;
    this.descricaoSaida = await repository.getDescricaoSaida();

    state = DescricaoSaidaState.success;
  }
}
