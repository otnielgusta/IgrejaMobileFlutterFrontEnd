import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/relatorio_anual_controller.dart';
import 'package:flutterigreja/controllers/states/relatorio_anual_state.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RelatorioAnualResult extends StatefulWidget {
  final int ano;

  const RelatorioAnualResult({Key key, this.ano}) : super(key: key);
  @override
  _RelatorioAnualResultState createState() => _RelatorioAnualResultState();
}

class _RelatorioAnualResultState extends State<RelatorioAnualResult> {
  final relatorioController = RelatorioAnualController();
  final List textos = ["Entradas", "Saídas", "Total Entradas", "Total Saidas"];
  final mascara =
      new MoneyMaskedTextController(leftSymbol: "R\$ ", decimalSeparator: ",");
  double saldo;
  double totalEntrada;
  double totalSaida;
  String saldoFinal;

  var f = NumberFormat("###.0#", "en_US");

  void getSaldo() {
    relatorioController.relatorio.totalentradas.forEach((element) {
      this.totalEntrada = double.tryParse(element.somaTotalEntrada);
    });

    relatorioController.relatorio.totalsaidas.forEach((element) {
      this.totalSaida = double.tryParse(element.somaTotalSaida);
    });

    this.totalEntrada = this.totalEntrada;
    this.totalSaida = this.totalSaida;

    this.saldo = this.totalEntrada - this.totalSaida;
    this.saldoFinal = f.format(this.saldo);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    relatorioController.getRelatorioAnual(ano: widget.ano);
    relatorioController.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ano.toString()}"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: getListaRealatoriosCerto(),
      ),
    );
  }

  Widget getListaRealatoriosCerto() {
    if (relatorioController.state == RelatorioAnualState.success) {
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
                  itemCount: relatorioController.relatorio.entradas.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorio.entradas[index].somaEntrada.toString()}"),
                          title: Text(
                            relatorioController
                                .relatorio.entradas[index].nomeDescricaoEntrada
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
                  itemCount: relatorioController.relatorio.saidas.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(relatorioController
                              .relatorio.saidas[index].nomeDescricaoSaida
                              .toString()),
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorio.saidas[index].somaSaida.toString()}"),
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
                  itemCount: relatorioController.relatorio.totalentradas.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        ListTile(
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorio.totalentradas[index].somaTotalEntrada.toString()}"),
                          title: Text("Total de Entradas"),
                        ),
                        ListTile(
                          title: Text("Total de Saidas"),
                          subtitle: Text(
                              "R\$ ${relatorioController.relatorio.totalsaidas[index].somaTotalSaida.toString()}"),
                        ),
                        ListTile(
                          title: Text("Saldo"),
                          subtitle: Text("R\$ ${this.saldoFinal}"),
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      );
    } else if (relatorioController.state == RelatorioAnualState.error) {
      return Text("Erro");
    } else {
      return Center(
        child: Lottie.asset("assets/images/loading.json"),
      );
    }
  }
}
