
import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza/Config.dart';

import '../../Storage.dart';
import '../../model/PizzaModel.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final List<Map<String, dynamic>> pizzaModels = [];

  bool isSaveActive = false;

  AdminBloc() : super(AdminInitial()) {
    on<AddNewPizza>((event, emit) {
      if (!isSaveActive) {
        isSaveActive = true;
      }

      addNewPizza();

      emit(AdminInitial());
    });

    on<SavePizza>((event, emit) async {
      emit(AdminLoading());

      try {
        final bool isSuccess = await savePizza();
        if (isSuccess) {
          emit(AdminSuccess());
        } else {
          emit(AdminError());
        }
      } catch (error) {
        log(error.toString());
        emit(AdminError());
      }
    });
  }

  void addNewPizza() {
    final Map<String, dynamic> pizzaData = {};
    final PizzaModel pizzaModel = PizzaModel();
    pizzaModel.id = math.Random().nextInt(1000);
    pizzaModel.imagePath = 'assets/img/pizza_1.png';

    pizzaData['model'] = pizzaModel;
    pizzaData['name'] = TextEditingController();
    pizzaData['price'] = TextEditingController();

    pizzaModels.add(pizzaData);
  }

  Future<bool> savePizza() async {
    bool isSuccess = false;

    await Future.delayed(Duration(milliseconds: Config.progressDuration), () async {
      for (Map<String, dynamic> item in pizzaModels) {
        String name = item['name'].text;
        String price = item['price'].text;

        if (name.trim().isNotEmpty && price.trim().isNotEmpty &&
            double.tryParse(price.trim()) != null) {
          log(name);
          log(price);
          log('${item['model'].count}');
          final PizzaModel pizzaModel = item['model'];
          await Storage.setInt(name: name, field: 'id', value: pizzaModel.id);
          await Storage.setInt(name: name, field: 'quantity', value: pizzaModel.count);
          await Storage.setString(name: name, field: 'price', value: price);
          await Storage.setString(name: name, field: 'imagePath', value: pizzaModel.imagePath);

          isSuccess = true;
        }
      }

      if (isSuccess) {
        pizzaModels.clear();
        isSaveActive = false;
      }
    });

    return isSuccess;
  }
}
