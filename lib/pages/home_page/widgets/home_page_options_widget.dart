import 'package:flutter/material.dart';
import 'package:flutterigreja/pages/AdicionarEntradasPage/adicionar_entradas_page.dart';
import 'package:lottie/lottie.dart';

class HomePageOptionsWidget extends StatelessWidget {
  final String url;
  final String text;
  final Widget rota;

  const HomePageOptionsWidget({
    Key key,
    this.url,
    this.text,
    this.rota,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => rota));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Expanded(flex: 2, child: Lottie.asset(url)),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
