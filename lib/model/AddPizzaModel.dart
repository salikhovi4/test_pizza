
import 'package:flutter/cupertino.dart';

class AddPizzaModel {
  late int count;
  late String imagePath;
  late TextEditingController nameController;
  late TextEditingController priceController;

  AddPizzaModel() {
    count = 1;
    imagePath = 'assets/img/pizza_1.png';
    nameController = TextEditingController();
    priceController = TextEditingController();
  }
}