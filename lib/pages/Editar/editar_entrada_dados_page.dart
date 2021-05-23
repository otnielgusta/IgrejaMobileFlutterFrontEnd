import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/adicionar_entrada_controller.dart';
import 'package:flutterigreja/controllers/descricao_entrada_controller.dart';
import 'package:flutterigreja/controllers/editar_entradas_dados_controller.dart';
import 'package:flutterigreja/controllers/states/adicionar_entrada_state.dart';
import 'package:flutterigreja/controllers/states/descricao_entrada_state.dart';
import 'package:flutterigreja/controllers/states/editar_entrada_dados_state.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/descricao_entrada_model.dart';
import 'package:flutterigreja/models/editar_entrada_dados_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../options_entrada.dart';
import 'editar_page.dart';

class EditarEntradaDadosPage extends StatefulWidget {
  final EditarEntradaDadosModel dadosEditar;

  const EditarEntradaDadosPage({Key key, this.dadosEditar}) : super(key: key);
  @override
  _EditarEntradaDadosPageState createState() => _EditarEntradaDadosPageState();
}

class _EditarEntradaDadosPageState extends State<EditarEntradaDadosPage> {
  final controller = DescricaoEntradaController();
  final editarEntradaController = EditarEntradaDadosController();

  TextEditingController dataController = TextEditingController();

  DateTime _dateTime;

  DescricaoEntrada selectedItem = DescricaoEntrada();

  EditarEntradaDadosModel editarEntradaModel = new EditarEntradaDadosModel();
  var numberFormat = NumberFormat('###.00#');
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

    editarEntradaController.stateNotifier.addListener(() {
      setState(() {});
    });

    controller.getDescricaoEntrada();
    maskController.text =
        numberFormat.format(widget.dadosEditar.valorEntrada).toString();
    valorController.text = maskController.text;

    dataController.text =
        f.format(DateTime.parse(widget.dadosEditar.dataEntrada));
    _dateTime = DateTime.parse(widget.dadosEditar.dataEntrada);
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == DescricaoEntradaState.success) {
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
                    "Edite os dados",
                    style: TextStyle(fontSize: 26),
                  ),
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
                            "Editar",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            size: 18,
                          )
                        ],
                      ))),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Lottie.asset("assets/images/loading.json"),
      );
    }
  }

  insereDados() async {
    editarEntradaModel.dataEntrada = _dateTime.toString();
    editarEntradaModel.idDescricaoEntrada = selectedItem.idDescricaoEntrada;
    editarEntradaModel.valorEntrada = double.parse(valorController.text);
    editarEntradaModel.idEntrada = widget.dadosEditar.idEntrada;
    await editarEntradaController.setEditarEntrada(
        editarDados: editarEntradaModel);
    setState(() {
      if (editarEntradaController.state == EditarEntradaDadosState.success) {
        showAlertDialog(context: context, icone: _iconeCheck);
      } else if (editarEntradaController.state ==
          EditarEntradaDadosState.error) {
        showAlertDialog(context: context, icone: _iconeError);
      }
      maskController.updateValue(0);
    });
  }

  Widget getDropdown() {
    selectedItem = controller.descricaoEntradaModel
        .descricaoEntrada[widget.dadosEditar.idDescricaoEntrada];
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
