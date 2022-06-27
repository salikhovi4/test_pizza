
import 'package:flutter/material.dart';

import 'CountControls.dart';
import 'TextInput.dart';
import '../Config.dart';
import '../Styles.dart';
import '../model/AddPizzaModel.dart';

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
  void didUpdateWidget(covariant AddPizzaComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    _model = widget.model;
  }

  void _increment() {
    _model.count += 1;

    setState(() {
      _isDecrementActive = _model.count > 1;
    });
  }

  void _decrement() {
    _model.count -= 1;

    setState(() {
      _isDecrementActive = _model.count > 1;
    });
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
                  Text('Name', style: Styles.textCardStyle,),

                  TextInput(controller: _model.nameController),

                  SizedBox(height: Config.mediumPadding,),

                  Text('Price', style: Styles.textCardStyle,),

                  TextInput(controller: _model.priceController),
                ],
              ),
            ),

            SizedBox(width: Config.mediumPadding,),

            CountControls(
              count: _model.count, decrement: _decrement, increment: _increment,
              isDecrementActive: _isDecrementActive,
            ),

            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     GradientButton(
            //       isActive: _isDecrementActive,
            //       onPressed: _decrement,
            //       child: SizedBox(
            //         width: Config.iconSize, height: Config.iconSize,
            //         child: Center(
            //           child: Padding(
            //             padding: const EdgeInsets.only(bottom: 3),
            //             child: Text('—', style: TextStyle(
            //               fontSize: Config.textMediumSize,
            //               color: _isDecrementActive
            //                   ? Config.textColorOnPrimary
            //                   : Config.primaryColor,
            //             ),),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //     SizedBox(
            //       width: Config.iconSize, height: Config.iconSize,
            //       child: Center(
            //         child: Text('${_model.count}', style: Styles.textCardStyle,),
            //       ),
            //     ),
            //
            //     GradientButton(
            //       onPressed: _increment,
            //       child: SizedBox(
            //         width: Config.iconSize, height: Config.iconSize,
            //         child: Center(
            //           child: Text('+', style: TextStyle(
            //             fontSize: Config.textMediumSize,
            //             color: Config.textColorOnPrimary
            //           ),),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ]
        ),
      ),
    );
  }
}
