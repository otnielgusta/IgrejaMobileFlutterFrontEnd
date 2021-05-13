import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutterigreja/models/RelatorioMensal/mes.dart';
import 'package:flutterigreja/models/RelatorioMensal/meses.dart';

class MesesRepository {
  Future<List<Mes>> getMeses() async {
    final response = await rootBundle.loadString("assets/database/meses.json");
    final list = jsonDecode(response) as List;
    final meses = list.map((e) => Mes.fromMap(e)).toList();

    return meses;
  }
}
