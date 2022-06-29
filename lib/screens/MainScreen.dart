
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'AdminScreen.dart';
import 'BasketScreen.dart';
import '../Config.dart';
import '../Styles.dart';
import '../Storage.dart';
import '../model/PizzaModel.dart';
import '../component/CustomAppBar.dart';
import '../component/GradientMask.dart';
import '../component/MainPizzaComponent.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<PizzaModel> _basket = [];

  List<PizzaModel> _pizzaModels = [];

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    List<PizzaModel> pizzaModels = [];
    Map<String, List<String>> groupedItems = {};
    Set<String> keys = await Storage.getKeys();

    for (String key in keys) {
      if (key.contains(Config.groupSeparator)) {
        List<String> nameAndField = key.split(Config.groupSeparator);
        if (groupedItems.containsKey(nameAndField[0])) {
          groupedItems[nameAndField[0]]!.add(key);
        } else {
          groupedItems[nameAndField[0]] = [key];
        }
      }
    }

    for (MapEntry entry in groupedItems.entries) {
      PizzaModel model = PizzaModel();
      model.name = entry.key;
      for (String valueKey in entry.value) {
        if (valueKey.contains('id')) {
          model.id = (await Storage.getInt(valueKey))!;
        }
        if (valueKey.contains('count')) {
          model.count = (await Storage.getInt(valueKey))!;
        }
        if (valueKey.contains('price')) {
          model.price = double.parse((await Storage.getString(valueKey))!);
        }
        if (valueKey.contains('imagePath')) {
          model.imagePath = (await Storage.getString(valueKey))!;
        }
      }

      pizzaModels.add(model);
    }

    setState(() {
      _pizzaModels = pizzaModels;
    });
  }

  void navigateToBasketScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BasketScreen(
        basket: _basket, updateParentState: () {setState(() {});},
        updateParentData: initialize,
      ),
    ),);
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
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding),
                child: CustomAppBar(
                  title: Text('Pizza Market', style: Styles.titleBoldStyle,),
                  actions: [
                    Badge(
                      showBadge: _basket.isNotEmpty,
                      badgeColor: Config.primaryColor,
                      badgeContent: Text(
                        '${_basket.length}', style: Styles.textSmallStyle,
                      ),
                      position: _basket.isEmpty
                          ? null : const BadgePosition(top: -3, end: 3),
                      child: GradientMask(child: IconButton(
                        icon: Icon(
                          Icons.shopping_basket, size: Config.iconSize,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          navigateToBasketScreen();
                        },
                      ),),
                    ),

                    SizedBox(width: Config.largePadding,),

                    GradientMask(child: IconButton(
                      icon: Icon(
                        Icons.person, size: Config.iconSize, color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AdminScreen(),
                        ));
                      },
                    ),),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Config.screenBackColor,
                  ),
                  child: RefreshIndicator(
                    onRefresh: initialize,
                    child: ListView.separated(
                      padding: EdgeInsets.all(Config.mediumPadding),
                      itemBuilder: (context, index) {
                        final PizzaModel model = _pizzaModels[index];
                        return MainPizzaComponent(
                          model: model,
                          addToBasket: () {
                            if (!_basket.any((element) => element.name == model.name)) {
                              setState(() {
                                _basket.add(model);
                              });
                            }
                            navigateToBasketScreen();
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Config.largePadding,
                      ),
                      itemCount: _pizzaModels.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
