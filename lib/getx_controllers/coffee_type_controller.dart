import 'package:get/get.dart';

class CoffeeTypeController extends GetxController {
  final _coffeeType = {}.obs;

  void changeCoffeeType(String coffeeType) {
    _coffeeType[coffeeType] = coffeeType;
    Get.snackbar(coffeeType, 'has been selected as your coffee type');
  }

  get coffeeType => _coffeeType;
}
