
import 'package:equatable/equatable.dart';

class PizzaModel extends Equatable {
  int count;
  late int id;
  late String name;
  late int quantity;
  late double price;
  late String imagePath;

  PizzaModel({this.count = 1,});

  @override
  List<Object?> get props => [id, name, quantity, price, imagePath];

  @override
  bool? get stringify => true;
}