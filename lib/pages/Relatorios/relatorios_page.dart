import 'package:flutter/material.dart';
import 'package:flutterigreja/pages/Relatorios/relatorio_anual_page.dart';
import 'package:flutterigreja/pages/Relatorios/relatorio_mensal_page.dart';
import 'package:flutterigreja/pages/Relatorios/widgets/escolher_relatorios_widgets.dart';

class Relatorios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 20,
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2, vertical: size.height * 0.10),
          children: [
            EscolherRelatorio(
              rota: RelatorioMensal(),
              texto: "Relatório Mensal",
              url: "assets/images/mensal.json",
            ),
            EscolherRelatorio(
              rota: RelatorioAnual(),
              texto: "Relatório Anual",
              url: "assets/images/anual.json",
            ),
          ],
        ),
      ),
    );
  }
}
