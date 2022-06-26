
import 'package:flutter/material.dart';
import 'package:pizza/Styles.dart';
import 'package:pizza/component/TextInput.dart';
import 'package:pizza/model/AddPizzaModel.dart';

import '../Config.dart';
import 'GradientButton.dart';

class AddPizzaComponent extends StatefulWidget {
  const AddPizzaComponent({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AddPizzaModel model;

  @override
  State<AddPizzaComponent> createState() => _AddPizzaComponentState();
}

class _AddPizzaComponentState extends State<AddPizzaComponent> {
  late AddPizzaModel _model;

  bool _isDecrementActive = false;

  @override
  void initState() {
    super.initState();

    _model = widget.model;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _model = widget.model;
  }

  void _increment() {
    _model.count += 1;

    setState(() {
      _isDecrementActive = _model.count > 1;
    });
  }

  void _decrement() {
    if (_model.count > 1) {
      _model.count -= 1;

      setState(() {
        _isDecrementActive = _model.count > 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Config.mediumBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(Config.mediumPadding),
        child: Row(
          children: <Widget>[
            Image.asset(
              _model.imagePath, width: Config.cardImageLargeSize,
              height: Config.cardImageLargeSize,
            ),

            SizedBox(width: Config.mediumPadding,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name', style: Styles.textAddingStyle,),

                  TextInput(controller: _model.nameController),

                  SizedBox(height: Config.mediumPadding,),

                  Text('Price', style: Styles.textAddingStyle,),

                  TextInput(controller: _model.priceController),
                ],
              ),
            ),

            SizedBox(width: Config.mediumPadding,),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GradientButton(
                  isActive: _isDecrementActive,
                  onPressed: _decrement,
                  child: SizedBox(
                    width: Config.iconSize, height: Config.iconSize,
                    child: Center(
                      child: Text('—', style: TextStyle(
                        fontSize: Config.textMediumSize,
                        color: _isDecrementActive
                            ? Config.textColorOnPrimary
                            : Config.primaryColor,
                      ),),
                    ),
                  ),
                ),

                SizedBox(
                  width: Config.iconSize, height: Config.iconSize,
                  child: Center(
                    child: Text('${_model.count}', style: Styles.textAddingStyle,),
                  ),
                ),

                GradientButton(
                  onPressed: _increment,
                  child: SizedBox(
                    width: Config.iconSize, height: Config.iconSize,
                    child: Center(
                      child: Text('+', style: TextStyle(
                        fontSize: Config.textMediumSize,
                        color: Config.textColorOnPrimary
                      ),),
                    ),
                  ),
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
