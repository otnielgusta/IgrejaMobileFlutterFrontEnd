import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/descricao_entrada_state.dart';
import 'package:flutterigreja/models/descricao_adicionar_entradas_model.dart';
import 'package:flutterigreja/repository/descricao_entradas_repository.dart';

class DescricaoEntradaController {
  final stateNotifier =
      ValueNotifier<DescricaoEntradaState>(DescricaoEntradaState.empty);

  set state(DescricaoEntradaState state) => stateNotifier.value = state;
  DescricaoEntradaState get state => stateNotifier.value;

  DescricaoEntradaModel descricaoEntradaModel;
  final repository = DescricaoEntradaRepository();

  void getDescricaoEntrada() async {
    state = DescricaoEntradaState.loading;
    this.descricaoEntradaModel = await this.repository.getDescricaoEntrada();
    state = DescricaoEntradaState.success;
  }
}
