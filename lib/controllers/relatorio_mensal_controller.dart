import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/relatorio_mensal_state.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_entradas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_model.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_saidas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_total_entradas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_total_saidas.dart';
import 'package:flutterigreja/repository/relatorio_mensal_repository.dart';

class RelatorioMensalController {
  final stateNotifier =
      ValueNotifier<RelatorioMensalState>(RelatorioMensalState.empty);

  set state(RelatorioMensalState state) => stateNotifier.value = state;
  RelatorioMensalState get state => stateNotifier.value;

  RelatorioMensalModel relatorioMensalModel;

  final repository = RelatorioMensalRepository();

  void getRelatorioMensal({@required int ano, @required int mes}) async {
    this.state = RelatorioMensalState.loading;
    this.relatorioMensalModel =
        await repository.getRelatorioMensal(mes: mes, ano: ano);

    if (this.relatorioMensalModel.entradas.length > 0) {
      this.state = RelatorioMensalState.success;
    } else {
      this.state = RelatorioMensalState.error;
    }
  }
}
