
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza/Storage.dart';
import 'package:pizza/Styles.dart';
import 'package:pizza/component/CustomAppBar.dart';
import 'package:pizza/component/GradientButton.dart';

import '../Config.dart';
import '../component/AddPizzaComponent.dart';
import '../model/AddPizzaModel.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final List<AddPizzaModel> _addingModels = [];

  void _addPizza() {
    setState(() {
      _addingModels.add(AddPizzaModel(id: Random().nextInt(1000)));
    });
  }

  void _savePizza() {
    bool success = false;
    for (AddPizzaModel item in _addingModels) {
      String name = item.nameController.text;
      String price = item.priceController.text;
      if (name.trim().isNotEmpty && price.trim().isNotEmpty &&
          double.tryParse(price.trim()) != null) {
        success = true;
        Storage.setInt('$name${Config.groupSeparator}id', item.id);
        Storage.setInt('$name${Config.groupSeparator}count', item.count);
        Storage.setString('$name${Config.groupSeparator}price', price);
        Storage.setString('$name${Config.groupSeparator}imagePath', item.imagePath);
      }
    }

    if (success) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Данные успешно сохранены!', style: Styles.textCardStyle,),
      ));

      setState(() {
        _addingModels.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Config.backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),

      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding),
                child: CustomAppBar(
                  title: Text('Add pizza', style: Styles.titleBoldStyle,),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/img/arrow_back.png', width: Config.iconSize,
                      height: Config.iconSize,
                    ),
                  ),
                  actions: [
                    GradientButton(
                      onPressed: _addPizza,
                      child: SizedBox(
                        width: Config.iconSize, height: Config.iconSize,
                        child: Center(
                          child: Text('+', style: TextStyle(
                            fontSize: Config.textMediumSize,
                            color: Config.textColorOnPrimary,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Config.screenBackColor,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(Config.mediumPadding),
                    itemBuilder: (context, index) => AddPizzaComponent(
                      model: _addingModels[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: Config.largePadding,
                    ),
                    itemCount: _addingModels.length,
                  ),
                ),
              ),

              Visibility(
                visible: _addingModels.isNotEmpty,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Config.screenBackColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Config.mediumPadding, horizontal: Config.mediumPadding,
                    ),
                    child: GradientButton(
                      borderRadius: Config.mediumBorderRadius,
                      onPressed: _savePizza,
                      child: Padding(
                        padding: EdgeInsets.all(Config.largePadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Save', style: Styles.saveButtonStyle,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
