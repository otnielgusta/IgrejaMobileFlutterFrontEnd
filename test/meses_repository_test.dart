import 'package:flutter_test/flutter_test.dart';
import 'package:flutterigreja/controllers/meses_controller.dart';
import 'package:flutterigreja/repository/meses_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test("description", () async {
    final controller = MesesController();
    await controller.getMeses();

    controller.meses.forEach((element) {
      print(element.nomeMes.toString());
      print(element.numeroMes.toString());
    });

    /*
    final repository = MesesRepository();

    final response = await repository.getMeses();
    response.forEach((element) {
      print(element.nomeMes);
      print(element.numeroMes);
    });

    */
  });
}
