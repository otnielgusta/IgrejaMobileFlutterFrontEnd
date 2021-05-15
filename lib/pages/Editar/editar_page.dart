import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutterigreja/controllers/adicionar_entrada_controller.dart';
import 'package:flutterigreja/controllers/descricao_entrada_controller.dart';
import 'package:flutterigreja/controllers/editar_entradas_controller.dart';
import 'package:flutterigreja/controllers/states/descricao_entrada_state.dart';
import 'package:flutterigreja/controllers/states/editar_entrada_state.dart';
import 'package:flutterigreja/models/adicionar_entrada_model.dart';
import 'package:flutterigreja/models/descricao_entrada_model.dart';
import 'package:flutterigreja/pages/Editar/editar_entrada_dados_page.dart';
import 'package:intl/intl.dart';

import '../../options_entrada.dart';

class EditarPage extends StatefulWidget {
  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  final controller = DescricaoEntradaController();
  final editarEntradaController = EditarEntradaController();
  final entradaController = AdicionarEntradaController();
  int _serverStatus;

  TextEditingController dataController = TextEditingController();

  DateTime _dateTime;

  DescricaoEntrada selectedItem;

  AdicionarEntradaModel entradaModel = new AdicionarEntradaModel();

  final f = DateFormat("dd/MM/yyyy");
  final f2 = DateFormat("yyyy-MM-dd");
  var maskController = new MoneyMaskedTextController(leftSymbol: "R\$ ");
  var valorController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: '');

  String _iconeCheck = "assets/images/check2.json";

  String _iconeError = "assets/images/error.json";

  AdicionarEntradaModel entradaEdicao;
  int idDescricaoEntrada;
  String dataEntrada;
  int valorEntrada;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataEntrada = null;
    idDescricaoEntrada = null;
    valorEntrada = null;
    editarEntradaController.getEditarEntrada(
        dataEntrada: dataEntrada,
        idDescricaoEntrada: idDescricaoEntrada,
        valorEntrada: valorEntrada);
    editarEntradaController.stateNotifier.addListener(() {
      setState(() {});
    });

    entradaController.stateNotifier.addListener(() {
      setState(() {});
    });
    controller.getDescricaoEntrada();
    dataController.text = f.format(DateTime.now());
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Entradas"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
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
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      idDescricaoEntrada = selectedItem.idDescricaoEntrada;
                      editarEntradaController.getEditarEntrada(
                          dataEntrada: "dataEntrada",
                          idDescricaoEntrada: idDescricaoEntrada,
                          valorEntrada: 0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [Text("Buscar"), Text("Descrição")],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double numero = double.parse(valorController.text);
                      valorEntrada = numero.toInt();
                      editarEntradaController.getEditarEntrada(
                          dataEntrada: "dataEntrada",
                          idDescricaoEntrada: -1,
                          valorEntrada: valorEntrada);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [Text("Buscar"), Text("Valor")],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      editarEntradaController.getEditarEntrada(
                          dataEntrada: f2.format(_dateTime).toString(),
                          idDescricaoEntrada: -1,
                          valorEntrada: 0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [Text("Buscar"), Text("Data")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: getDataTable())
          ],
        ),
      ),
    );
  }

  Widget getDataTable() {
    if (editarEntradaController.state == EditarEntradaState.success) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                  label: Text(
                'DATA',
              )),
              DataColumn(
                label: Text(
                  'DESCRIÇAO',
                ),
              ),
              DataColumn(
                label: Text(
                  'VALOR',
                ),
              ),
              DataColumn(
                label: Text(
                  'AÇÕES',
                ),
              ),
            ],
            rows: editarEntradaController.editarEntrada.results
                .map((e) => DataRow(cells: [
                      DataCell(Text(
                          f.format(DateTime.parse(e.dataEntrada)).toString())),
                      DataCell(Text(e.nomeDescricaoEntrada.toString())),
                      DataCell(Text("R\$ ${e.valorEntrada.toString()}")),
                      DataCell(Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            EditarEntradaDadosPage()));
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              onPressed: () {})
                        ],
                      ))
                    ]))
                .toList(),
          ),
        ),
      );
    } else {
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                  label: Text(
                'DATA',
              )),
              DataColumn(
                label: Text(
                  'DESCRIÇAO',
                ),
              ),
              DataColumn(
                label: Text(
                  'VALOR',
                ),
              ),
              DataColumn(
                label: Text(
                  'AÇÕES',
                ),
              ),
            ],
            rows: [],
          ),
        ),
      );
    }
  }

  Widget getDropdown() {
    if (controller.state == DescricaoEntradaState.success) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5),
            child: DropdownButtonFormField<DescricaoEntrada>(
              onTap: () {
                setState(() {});
              },
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
}
