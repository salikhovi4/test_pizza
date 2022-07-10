
part of 'pizza_count_bloc.dart';

@immutable
abstract class PizzaCardEvent {}

class CountIncrement extends PizzaCardEvent {}

class CountDecrement extends PizzaCardEvent {}
