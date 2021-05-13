import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EscolherRelatorio extends StatelessWidget {
  final String url;
  final String texto;
  final Widget rota;
  const EscolherRelatorio({
    Key key,
    this.url,
    this.texto,
    this.rota,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 4, child: Lottie.asset(url, width: size.width * 0.4)),
            Expanded(
                flex: 1,
                child: Text(
                  texto,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
