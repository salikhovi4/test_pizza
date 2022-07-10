
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pizza_count_event.dart';

class PizzaCountBloc extends Bloc<PizzaCardEvent, int> {
  late bool isDecrementActive;
  late bool isIncrementActive;

  int count;
  int quantity;

  PizzaCountBloc({required this.count, this.quantity = 1}) : super(count) {
    isDecrementActive = count > 1;
    isIncrementActive = count < quantity;

    on<CountIncrement>((event, emit) {
      if (!isDecrementActive) {
        isDecrementActive = true;
      }
      isIncrementActive = count + 1 < quantity;

      emit(state + 1);
    });

    on<CountDecrement>((event, emit) {
      isDecrementActive = state - 1 > 1;
      isIncrementActive = count < quantity;

      emit(state - 1);
    });
  }
}
