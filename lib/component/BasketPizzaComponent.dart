
import 'package:flutter/material.dart';
import 'package:pizza/component/CountControls.dart';

import '../Config.dart';
import '../Styles.dart';
import '../model/PizzaModel.dart';

class BasketPizzaComponent extends StatefulWidget {
  const BasketPizzaComponent({
    Key? key,
    required this.model,
    required this.updateParentState,
  }) : super(key: key);

  final PizzaModel model;
  final Function updateParentState;

  @override
  State<BasketPizzaComponent> createState() => _BasketPizzaComponentState();
}

class _BasketPizzaComponentState extends State<BasketPizzaComponent> {
  late PizzaModel _model;
  late bool _isDecrementActive;
  late bool _isIncrementActive;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant BasketPizzaComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  void _initialize() {
    _model = widget.model;

    _updateControls();
  }

  void _updateControls() {
    _isDecrementActive = _model.currentCount > 1;
    _isIncrementActive = _model.currentCount < _model.count;
  }

  void _decrement() {
    _model.currentCount -= 1;

    _updateControls();

    setState(() {});
    widget.updateParentState();
  }

  void _increment() {
    _model.currentCount += 1;

    _updateControls();

    setState(() {});
    widget.updateParentState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              _model.imagePath, width: Config.cardImageLargeSize,
              height: Config.cardImageLargeSize,
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_model.name, style: Styles.textCardStyle,),
                    Text(r'$' '${_model.price.round()}', style: Styles.priceMediumStyle,)
                  ],
                )
              ),
            ),

            CountControls(
              count: _model.currentCount, decrement: _decrement,
              increment: _increment, isDecrementActive: _isDecrementActive,
              isIncrementActive: _isIncrementActive,
            )
          ],
        ),
      ),
    );
  }
}
