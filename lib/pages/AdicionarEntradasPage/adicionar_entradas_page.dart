import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/adicionar_entrada_controller.dart';
import 'package:flutterigreja/controllers/states/adicionar_entrada_state.dart';
import 'package:flutterigreja/controllers/descricao_entrada_controller.dart';
import 'package:flutterigreja/controllers/states/descricao_entrada_state.dart';

import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/descricao_adicionar_entradas_model.dart';
import 'package:flutterigreja/models/descricao_entrada_model.dart';
import 'package:flutterigreja/pages/Editar/editar_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../options_entrada.dart';

class AdicionarEntradas extends StatefulWidget {
  const AdicionarEntradas({Key key}) : super(key: key);

  @override
  _AdicionarEntradasState createState() => _AdicionarEntradasState();
}

class _AdicionarEntradasState extends State<AdicionarEntradas> {
  final controller = DescricaoEntradaController();
  final entradaController = AdicionarEntradaController();
  int _serverStatus;

  TextEditingController dataController = TextEditingController();

  DateTime _dateTime;

  DescricaoEntrada selectedItem;

  AdicionarEntradaModel entradaModel = new AdicionarEntradaModel();

  final f = DateFormat("dd/MM/yyyy");
  var maskController = new MoneyMaskedTextController(leftSymbol: "R\$ ");
  var valorController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: '');

  String _iconeCheck = "assets/images/check2.json";

  String _iconeError = "assets/images/error.json";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    entradaController.stateNotifier.addListener(() {
      setState(() {});
    });

    controller.getDescricaoEntrada();
    dataController.text = f.format(DateTime.now());
    _dateTime = DateTime.now();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  void choiceAction(String choice) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => EditarPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Adicionar Entradas",
                  style: TextStyle(fontSize: 26),
                ),
                PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return OptionsEntrada.choices.map((String e) {
                        return PopupMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList();
                    })
              ],
            ),
            SizedBox(
              height: 40,
            ),
            getDropdown(),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  valorController.text = maskController.value.text;
                });
              },
              keyboardType: TextInputType.number,
              controller: maskController,
              decoration: InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              readOnly: true,
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2222),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.deepPurple,
                            onPrimary: Colors.white,
                            surface: Colors.deepPurple,
                            onSurface: Colors.black,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child,
                      );
                    }).then((value) {
                  setState(() {
                    _dateTime = value;
                    dataController.text = f.format(_dateTime).toString();
                  });
                });
              },
              onChanged: (value) {
                setState(() {});
              },
              controller: dataController,
              decoration: InputDecoration(
                labelText: "Data",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      insereDados();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Adicionar",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add_rounded,
                          size: 28,
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  Widget showPopupMenu() {
    (BuildContext context) =>
        PopupMenuButton<String>(itemBuilder: (BuildContext context) {
          new PopupMenuItem<String>(
            value: "Editar Entrada",
            child: Text("Editar Entrada"),
          );
        });
  }

  insereDados() async {
    entradaModel.dataEntrada = _dateTime.toString();
    entradaModel.idDescricaoEntrada = selectedItem.idDescricaoEntrada;
    entradaModel.valorEntrada = double.parse(valorController.text);
    await entradaController.setAdicionarEntrada(entradaModel: entradaModel);
    setState(() {
      if (entradaController.state == AdicionarEntradaState.success) {
        if (entradaController.status == 201) {
          showAlertDialog(context: context, icone: _iconeCheck);
        } else {
          showAlertDialog(context: context, icone: _iconeError);
        }
      }
      maskController.updateValue(0);
    });
  }

  Widget getDropdown() {
    if (controller.state == DescricaoEntradaState.success) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            child: DropdownButtonFormField<DescricaoEntrada>(
              dropdownColor: Colors.white,
              isExpanded: true,
              hint: Text("Selecione"),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.deepPurple,
              ),
              style: TextStyle(color: Colors.black),
              iconEnabledColor: Colors.amber,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
              value: selectedItem,
              items: controller.descricaoEntradaModel.descricaoEntrada
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nomeDescricaoEntrada.toString()),
                      ))
                  .toList(),
              onChanged: (DescricaoEntrada value) {
                setState(() {
                  selectedItem = value;
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
                  'Descrição',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              )),
        ],
      );
    } else if (controller.state == DescricaoEntradaState.loading) {
      return Center(
        child: DropdownButtonFormField(
          isExpanded: true,
          onTap: () {
            AlertDialog(
              title: Text("Espere carregar"),
            );
          },
          hint: Text("Carregando..."),
          onChanged: (_) {
            AlertDialog(
              title: Text("Espere carregar"),
            );
          },
        ),
      );
    }
  }

  showAlertDialog({@required BuildContext context, @required String icone}) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Lottie.asset(icone),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1, microseconds: 500), () {
          Navigator.of(context).pop(true);
        });
        return alert;
      },
    );
  }
}
