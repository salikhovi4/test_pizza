
import 'package:flutter/material.dart';
import 'package:pizza/Config.dart';
import 'package:pizza/Storage.dart';
import 'package:pizza/Styles.dart';
import 'package:pizza/component/CustomAppBar.dart';
import 'package:pizza/component/GradientMask.dart';
import 'package:pizza/component/MainPizzaComponent.dart';
import 'package:pizza/screens/AdminScreen.dart';
import 'package:pizza/screens/BasketScreen.dart';

import '../model/PizzaModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  List<PizzaModel> basket = [];
  List<PizzaModel> pizzaModels = [];

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    setState(() {
      isLoading = true;
    });

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
      isLoading = false;
    });
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
                    GradientMask(child: IconButton(
                      icon: Icon(Icons.shopping_basket, size: Config.iconSize, color: Colors.white,),
                      onPressed: () {
                      },
                    ),),

                    SizedBox(width: Config.largePadding,),

                    GradientMask(child: IconButton(
                      icon: Icon(Icons.person, size: Config.iconSize, color: Colors.white,),
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
                  child: ListView.separated(
                    padding: EdgeInsets.all(Config.mediumPadding),
                    itemBuilder: (context, index) => MainPizzaComponent(
                      model: pizzaModels[index],
                      addToBasket: () {
                        basket.add(pizzaModels[index]);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BasketScreen(basket: basket),
                        ),);
                      },
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: Config.largePadding,
                    ),
                    itemCount: pizzaModels.length,
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
