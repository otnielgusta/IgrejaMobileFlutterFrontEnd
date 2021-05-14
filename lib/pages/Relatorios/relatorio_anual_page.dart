import 'package:flutter/material.dart';
import 'package:flutterigreja/controllers/busca_ano_mensal_controller.dart';
import 'package:flutterigreja/controllers/meses_controller.dart';
import 'package:flutterigreja/controllers/states/busca_anos_state.dart';
import 'package:flutterigreja/controllers/states/meses_state.dart';
import 'package:flutterigreja/models/RelatorioMensal/ano_model.dart';
import 'package:flutterigreja/models/RelatorioMensal/mes.dart';
import 'package:flutterigreja/pages/Relatorios/relatorio_anual_result.dart';
import 'package:flutterigreja/pages/Relatorios/relatorio_mensal_result.dart';
import 'package:lottie/lottie.dart';

class RelatorioAnual extends StatefulWidget {
  @override
  _RelatorioAnualState createState() => _RelatorioAnualState();
}

class _RelatorioAnualState extends State<RelatorioAnual> {
  final anoController = BuscaAnoMensalController();

  Ano anoSelected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    anoController.getAnosMensal();
    anoController.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (anoController.state == BuscaAnosMensalState.success) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Relatório Anual",
                    style: TextStyle(fontSize: 26, color: Colors.deepPurple),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              getDropdownAno(),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    int ano = anoSelected.ano;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RelatorioAnualResult(
                                ano: ano,
                              )),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Buscar",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: Icon(
                          Icons.search,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (anoController.state == BuscaAnosMensalState.error) {
      return Center(
        child: Lottie.asset("assets/images/error.json"),
      );
    } else {
      return Center(
        child: Lottie.asset("assets/images/loading.json"),
      );
    }
  }

  Widget getDropdownAno() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 5),
          child: DropdownButtonFormField<Ano>(
            dropdownColor: Colors.white,
            isExpanded: true,
            hint: Text("Selecione"),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.deepPurple,
            ),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
            ),
            iconEnabledColor: Colors.amber,
            value: anoSelected,
            items: anoController.anos.anos
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.ano.toString()),
                  ),
                )
                .toList(),
            onChanged: (Ano value) {
              setState(() {
                anoSelected = value;
              });
            },
          ),
        ),
        Positioned(
            left: 7,
            top: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 0,
                left: 3,
                right: 3,
              ),
              color: Colors.white,
              child: Text(
                'Ano',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            )),
      ],
    );
  }
}
