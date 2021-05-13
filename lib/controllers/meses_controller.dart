import 'package:flutter/cupertino.dart';
import 'package:flutterigreja/controllers/states/meses_state.dart';
import 'package:flutterigreja/models/RelatorioMensal/mes.dart';
import 'package:flutterigreja/models/RelatorioMensal/meses.dart';
import 'package:flutterigreja/repository/meses_repository.dart';

class MesesController {
  final stateNotifier = ValueNotifier<MesesState>(MesesState.empty);
  set state(MesesState state) => stateNotifier.value = state;
  MesesState get state => stateNotifier.value;

  List<Mes> meses;
  final repository = MesesRepository();

  void getMeses() async {
    this.state = MesesState.loading;
    this.meses = await repository.getMeses();
    if (this.meses.length > 0) {
      this.state = MesesState.success;
    } else {
      this.state = MesesState.error;
    }
  }
}
