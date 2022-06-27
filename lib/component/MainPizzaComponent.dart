
import 'package:flutter/material.dart';

import '../Styles.dart';
import '../Config.dart';
import '../model/PizzaModel.dart';

class MainPizzaComponent extends StatelessWidget {
  const MainPizzaComponent({
    Key? key,
    required this.model,
    required this.addToBasket,
  }) : super(key: key);

  final PizzaModel model;
  final Function() addToBasket;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: addToBasket,
      child: Card(
        elevation: 45,
        shadowColor: Config.shadowColor.withOpacity(.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Config.mediumBorderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Config.largePadding / 2, Config.largePadding / 2,
            Config.largePadding, Config.largePadding / 2,
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                model.imagePath, width: Config.cardImageSize,
                height: Config.cardImageSize,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding,),
                  child: Text(model.name, style: Styles.textCardStyle,),
                ),
              ),

              Text(r'$' '${model.price.round()}', style: Styles.priceLargeStyle,)
            ],
          ),
        ),
      ),
    );
  }
}
