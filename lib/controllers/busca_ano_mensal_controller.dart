import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/busca_anos_state.dart';
import 'package:flutterigreja/models/RelatorioMensal/busca_ano_mensal_model.dart';
import 'package:flutterigreja/repository/busca_anos_mensal_repository.dart';

class BuscaAnoMensalController {
  final stateNotifier =
      ValueNotifier<BuscaAnosMensalState>(BuscaAnosMensalState.empty);

  set state(BuscaAnosMensalState state) => stateNotifier.value = state;
  BuscaAnosMensalState get state => stateNotifier.value;

  BuscaAnoMensalModel anos;
  final repository = BuscaAnosMensalRepository();

  void getAnosMensal() async {
    this.state = BuscaAnosMensalState.loading;
    this.anos = await repository.getAnoMensal();
    if (this.anos.anos.length > 0) {
      this.state = BuscaAnosMensalState.success;
    } else {
      this.state = BuscaAnosMensalState.error;
    }
  }
}
