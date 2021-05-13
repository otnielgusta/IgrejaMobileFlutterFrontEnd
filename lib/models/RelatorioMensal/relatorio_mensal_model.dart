import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_entradas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_saidas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_total_entradas.dart';
import 'package:flutterigreja/models/RelatorioMensal/relatorio_mensal_total_saidas.dart';

class RelatorioMensalModel {
  List<Entradas> entradas;
  List<Saidas> saidas;
  List<Totalentradas> totalentradas;
  List<Totalsaidas> totalsaidas;

  RelatorioMensalModel(
      {this.entradas, this.saidas, this.totalentradas, this.totalsaidas});

  RelatorioMensalModel.fromJson(Map<String, dynamic> json) {
    if (json['entradas'] != null) {
      entradas = new List<Entradas>();
      json['entradas'].forEach((v) {
        entradas.add(new Entradas.fromJson(v));
      });
    }
    if (json['saidas'] != null) {
      saidas = new List<Saidas>();
      json['saidas'].forEach((v) {
        saidas.add(new Saidas.fromJson(v));
      });
    }
    if (json['totalentradas'] != null) {
      totalentradas = new List<Totalentradas>();
      json['totalentradas'].forEach((v) {
        totalentradas.add(new Totalentradas.fromJson(v));
      });
    }
    if (json['totalsaidas'] != null) {
      totalsaidas = new List<Totalsaidas>();
      json['totalsaidas'].forEach((v) {
        totalsaidas.add(new Totalsaidas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entradas != null) {
      data['entradas'] = this.entradas.map((v) => v.toJson()).toList();
    }
    if (this.saidas != null) {
      data['saidas'] = this.saidas.map((v) => v.toJson()).toList();
    }
    if (this.totalentradas != null) {
      data['totalentradas'] =
          this.totalentradas.map((v) => v.toJson()).toList();
    }
    if (this.totalsaidas != null) {
      data['totalsaidas'] = this.totalsaidas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
