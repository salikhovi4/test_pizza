
part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AddNewPizza extends AdminEvent {}

class SavePizza extends AdminEvent {}
