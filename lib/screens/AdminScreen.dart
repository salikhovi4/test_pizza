
import 'package:flutter/material.dart';
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
  List<AddPizzaModel> _addingModels = [];

  void _addPizza() {
    setState(() {
      _addingModels.add(AddPizzaModel());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Config.backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),

      child: SafeArea(
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
              child: Material(
                color: Config.screenBackColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Config.mediumPadding, horizontal: Config.mediumPadding,
                  ),
                  child: GradientButton(
                    borderRadius: Config.mediumBorderRadius,
                    onPressed: () {},
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
      )
    );
  }
}
