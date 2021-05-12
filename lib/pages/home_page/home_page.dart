import 'package:flutter/material.dart';
import 'package:flutterigreja/pages/AdicionarEntradasPage/adicionar_entradas_page.dart';
import 'package:flutterigreja/pages/AdicionarSaidasPage/adicionar_saidas_page.dart';
import 'package:flutterigreja/pages/home_page/widgets/home_page_options_widget.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: GridView.count(
          primary: false,
          crossAxisCount: 1,
          mainAxisSpacing: 20,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: 40),
          children: [
            HomePageOptionsWidget(
              text: "Entradas",
              url: "assets/images/entrada.json",
              rota: AdicionarEntradas(),
            ),
            HomePageOptionsWidget(
              text: "Saidas",
              url: "assets/images/saida.json",
              rota: AdicionarSaidas(),
            ),
            HomePageOptionsWidget(
              text: "Relatorios",
              url: "assets/images/relatorio.json",
            ),
          ],
        ),
      ),
    );
  }
}
