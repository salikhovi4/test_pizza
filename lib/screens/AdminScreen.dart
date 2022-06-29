
import 'dart:math';

import 'package:flutter/material.dart';

import '../Config.dart';
import '../Styles.dart';
import '../Storage.dart';
import '../model/AddPizzaModel.dart';
import '../component/CustomAppBar.dart';
import '../component/GradientButton.dart';
import '../component/AddPizzaComponent.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({
    Key? key,
    required this.updateParentData,
  }) : super(key: key);

  final Function updateParentData;

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final List<AddPizzaModel> _addingModels = [];

  bool _isLoading = false;

  void _addPizza() {
    setState(() {
      _addingModels.add(AddPizzaModel(id: Random().nextInt(1000)));
    });
  }

  Future<void> _savePizza() async {
    setState(() {
      _isLoading = true;
    });

    bool success = false;
    for (AddPizzaModel item in _addingModels) {
      String name = item.nameController.text;
      String price = item.priceController.text;
      if (name.trim().isNotEmpty && price.trim().isNotEmpty &&
          double.tryParse(price.trim()) != null) {
        success = true;
        await Storage.setInt(name: name, field: 'id', value: item.id);
        await Storage.setInt(name: name, field: 'count', value: item.count);
        await Storage.setString(name: name, field: 'price', value: price);
        await Storage.setString(name: name, field: 'imagePath', value: item.imagePath);
      }
    }

    if (success) {
      _addingModels.clear();

      setState(() {
        _isLoading = false;
      });

      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Данные успешно сохранены!', style: Styles.textCardStyle,),
      ));

      widget.updateParentData();
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
              ),

              _isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive(),)
                  : const SizedBox()
            ],
          ),
        ),
      )
    );
  }
}
