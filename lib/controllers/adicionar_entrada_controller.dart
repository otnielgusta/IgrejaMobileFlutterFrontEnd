import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/adicionar_entrada_state.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/repository/adicionar_entrada_repository.dart';

class AdicionarEntradaController {
  final stateNotifier =
      ValueNotifier<AdicionarEntradaState>(AdicionarEntradaState.empty);

  set state(AdicionarEntradaState state) => stateNotifier.value = state;
  AdicionarEntradaState get state => stateNotifier.value;

  int status;
  final repository = AdicionarEntradaRepository();

  setAdicionarEntrada({
    @required AdicionarEntradaModel entradaModel,
  }) async {
    state = AdicionarEntradaState.loading;
    final response =
        await repository.setAdiconarEntrada(entradaModel: entradaModel);
    this.status = response;

    if (this.status == 201) {
      state = AdicionarEntradaState.success;
    } else {
      state = AdicionarEntradaState.error;
    }
  }
}
