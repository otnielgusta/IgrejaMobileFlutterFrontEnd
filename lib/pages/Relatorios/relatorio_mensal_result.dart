import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/relatorio_mensal_controller.dart';
import 'package:flutterigreja/controllers/states/relatorio_mensal_state.dart';
import 'package:flutterigreja/models/RelatorioMensal/mes.dart';
import 'package:lottie/lottie.dart';

class RelatorioMensalResult extends StatefulWidget {
  final int ano;
  final Mes mes;

  const RelatorioMensalResult({Key key, this.ano, this.mes}) : super(key: key);
  @override
  _RelatorioMensalResultState createState() => _RelatorioMensalResultState();
}

class _RelatorioMensalResultState extends State<RelatorioMensalResult> {
  final relatorioController = RelatorioMensalController();
  final List textos = ["Entradas", "Saídas", "Total Entradas", "Total Saidas"];
  final mascara =
      new MoneyMaskedTextController(leftSymbol: "R\$ ", decimalSeparator: ",");
  double saldo;
  double totalEntrada;
  double totalSaida;

  void getSaldo() {
    relatorioController.relatorioMensalModel.totalentradas.forEach((element) {
      this.totalEntrada = double.tryParse(element.somaTotalEntrada);
    });

    relatorioController.relatorioMensalModel.totalsaidas.forEach((element) {
      this.totalSaida = double.tryParse(element.somaTotalSaida);
    });

    this.saldo = this.totalEntrada - this.totalSaida;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    relatorioController.getRelatorioMensal(
        ano: widget.ano, mes: widget.mes.numeroMes);
    relatorioController.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.mes.nomeMes.toString()} de ${widget.ano.toString()}"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: getListaRealatoriosCerto(),
      ),
    );
  }

  Widget getListaRealatoriosCerto() {
    if (relatorioController.state == RelatorioMensalState.success) {
      getSaldo();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Entradas",
                style: TextStyle(fontSize: 24),
              )),
              ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:
                      relatorioController.relatorioMensalModel.entradas.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorioMensalModel.entradas[index].somaEntrada.toString()}"),
                          title: Text(
                            relatorioController.relatorioMensalModel
                                .entradas[index].nomeDescricaoEntrada
                                .toString(),
                          ),
                        ),
                      ],
                    );
                  }),
              Divider(
                height: 50,
                thickness: 2,
              ),
              Center(
                  child: Text(
                "Saídas",
                style: TextStyle(fontSize: 24),
              )),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      relatorioController.relatorioMensalModel.saidas.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(relatorioController.relatorioMensalModel
                              .saidas[index].nomeDescricaoSaida
                              .toString()),
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorioMensalModel.saidas[index].somaSaida.toString()}"),
                        ),
                      ],
                    );
                  }),
              Divider(
                height: 50,
                thickness: 2,
              ),
              Center(
                child: Text(
                  "Totais",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: relatorioController
                      .relatorioMensalModel.totalentradas.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorioMensalModel.totalentradas[index].somaTotalEntrada.toString()}"),
                          title: Text("Total de Entradas"),
                        ),
                        ListTile(
                          title: Text("Total de Saidas"),
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorioMensalModel.totalsaidas[index].somaTotalSaida.toString()}"),
                        ),
                        ListTile(
                          title: Text("Saldo"),
                          subtitle: Text("R\$ ${this.saldo}"),
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      );
    } else if (relatorioController.state == RelatorioMensalState.error) {
      return Text("Erro");
    } else {
      return Center(
        child: Lottie.asset("assets/images/loading.json"),
      );
    }
  }

  Widget getListaRelatorios() {
    if (relatorioController.state == RelatorioMensalState.success) {
      this.getSaldo();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (_, index) {
              return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        textos[index],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: relatorioController
                              .relatorioMensalModel.entradas.length,
                          itemBuilder: (_, indexEntradas) {
                            return ListTile(
                              title: Text(
                                "${relatorioController.relatorioMensalModel.entradas[indexEntradas].nomeDescricaoEntrada}: ${relatorioController.relatorioMensalModel.entradas[indexEntradas].somaEntrada}",
                              ),
                            );
                          }),
                    ],
                  ));
            }),
      );
    } else if (relatorioController.state == RelatorioMensalState.error) {
      return Text("Erro");
    } else {
      return Text("Carregando...");
    }
  }
}
