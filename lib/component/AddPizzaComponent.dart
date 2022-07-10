
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CountControls.dart';
import 'TextInput.dart';
import '../Config.dart';
import '../Styles.dart';
import '../model/PizzaModel.dart';
import '../bloc/pizza_count_bloc/pizza_count_bloc.dart';

class AddPizzaComponent extends StatelessWidget {
  const AddPizzaComponent({
    Key? key,
    required this.model,
    required this.nameController,
    required this.priceController,
  }) : super(key: key);

  final PizzaModel model;
  final TextEditingController nameController;
  final TextEditingController priceController;

  void _increment(PizzaCountBloc cardBloc) {
    model.count += 1;

    cardBloc.add(CountIncrement());
  }

  void _decrement(PizzaCountBloc cardBloc) {
    model.count -= 1;

    cardBloc.add(CountDecrement());
  }

  @override
  Widget build(BuildContext context) {
    final PizzaCountBloc pizzaCountBloc = context.read<PizzaCountBloc>();
    return BlocBuilder<PizzaCountBloc, int>(
      builder: (context, state) => Card(
        elevation: 45,
        shadowColor: Config.shadowColor.withOpacity(.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.mediumBorderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(Config.mediumPadding),
          child: Row(
            children: <Widget>[
              Image.asset(
                model.imagePath, width: Config.cardImageLargeSize,
                height: Config.cardImageLargeSize,
              ),

              SizedBox(width: Config.mediumPadding,),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Name', style: Styles.textCardStyle,),

                    TextInput(controller: nameController),

                    SizedBox(height: Config.mediumPadding,),

                    Text('Price', style: Styles.textCardStyle,),

                    TextInput(controller: priceController),
                  ],
                ),
              ),

              SizedBox(width: Config.mediumPadding,),

              CountControls(
                count: model.count,
                decrement: () {
                  _decrement(pizzaCountBloc);
                },
                increment: () {
                  _increment(pizzaCountBloc);
                },
                isDecrementActive: pizzaCountBloc.isDecrementActive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
