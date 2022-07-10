
part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {}

class AdminError extends AdminState {}
