import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/relatorio_anual_state.dart';
import 'package:flutterigreja/models/relatorio_anual_model.dart';
import 'package:flutterigreja/repository/relatorio_anual_repository.dart';

class RelatorioAnualController {
  final stateNotifier =
      ValueNotifier<RelatorioAnualState>(RelatorioAnualState.empty);

  set state(RelatorioAnualState state) => stateNotifier.value = state;
  RelatorioAnualState get state => stateNotifier.value;

  RelatorioAnualModel relatorio;

  final repository = RelatorioAnualRepository();

  void getRelatorioAnual({int ano}) async {
    this.state = RelatorioAnualState.loading;
    this.relatorio = await repository.getRelatorioAnual(ano: ano);
    if (this.relatorio.entradas.length > 0) {
      this.state = RelatorioAnualState.success;
    } else {
      this.state = RelatorioAnualState.error;
    }
  }
}
