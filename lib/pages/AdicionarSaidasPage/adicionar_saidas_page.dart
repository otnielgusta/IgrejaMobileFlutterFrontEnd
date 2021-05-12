import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/adicionar_saida_controller.dart';
import 'package:flutterigreja/controllers/descricao_saida_controller.dart';
import 'package:flutterigreja/controllers/states/adicionar_saida_state.dart';
import 'package:flutterigreja/controllers/states/descricao_saida_state.dart';
import 'package:flutterigreja/models/adicionar_saida_model.dart';
import 'package:flutterigreja/models/descricao_saida_items_model.dart';
import 'package:flutterigreja/options_saida.dart';
import 'package:intl/intl.dart';

import '../../options_entrada.dart';

class AdicionarSaidas extends StatefulWidget {
  @override
  _AdicionarSaidasState createState() => _AdicionarSaidasState();
}

class _AdicionarSaidasState extends State<AdicionarSaidas> {
  final controller = DescricaoSaidaController();
  final saidaController = AdicionarSaidasController();
  int _serverStatus;

  TextEditingController dataController = TextEditingController();

  DateTime _dateTime;

  DescricaoSaidaItemsModel selectedItem;

  AdicionarSaidaModel saidaModel = new AdicionarSaidaModel();

  final f = DateFormat("dd/MM/yyyy");
  var maskController = new MoneyMaskedTextController(leftSymbol: "R\$ ");
  var valorController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: '');

  String _iconeCheck = "assets/images/check.gif";

  String _iconeError = "assets/images/error.gif";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saidaController.stateNotifier.addListener(() {
      setState(() {});
    });
    controller.getDescricaoSaida();
    dataController.text = f.format(DateTime.now());
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  void choiceAction(String choice) {
    print("trabalhando");
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
                  "Adicionar Saídas",
                  style: TextStyle(fontSize: 26),
                ),
                PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return OptionsSaida.choices.map((String e) {
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
                  print(valorController.text);
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

                    print(dataController.text);
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
    saidaModel.dataSaida = _dateTime.toString();
    saidaModel.idDescricaoSaida = selectedItem.idDescricaoSaida;
    saidaModel.valorSaida = double.parse(valorController.text);
    await saidaController.setSaidas(saida: saidaModel);
    setState(() {
      if (saidaController.state == AdicionarSaidaState.success) {
        if (saidaController.status == 201) {
          showAlertDialog(context, "Saída Inserida", _iconeCheck);
        } else {
          showAlertDialog(context, "Saída não inserida", _iconeError);
        }
      }
      maskController.updateValue(0);
    });
  }

  Widget getDropdown() {
    if (controller.state == DescricaoSaidaState.success) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            child: DropdownButtonFormField<DescricaoSaidaItemsModel>(
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
              items: controller.descricaoSaida.descricaoSaida
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.nomeDescricaoSaida.toString()),
                      ))
                  .toList(),
              onChanged: (DescricaoSaidaItemsModel value) {
                setState(() {
                  selectedItem = value;
                  print(selectedItem.nomeDescricaoSaida);
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
    } else if (controller.state == DescricaoSaidaState.loading) {
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

  showAlertDialog(@required BuildContext context, @required String text,
      @required String icone) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 26),
        )),
        content: Image.asset(
          icone,
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return alert;
      },
    );
  }
}
