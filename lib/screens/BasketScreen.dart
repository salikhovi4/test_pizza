
import 'package:flutter/material.dart';
import 'package:pizza/component/BasketPizzaComponent.dart';
import 'package:pizza/model/PizzaModel.dart';

import '../Config.dart';
import '../Styles.dart';
import '../component/CustomAppBar.dart';
import '../component/Gradient.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({
    Key? key,
    required this.basket,
  }) : super(key: key);

  final List<PizzaModel> basket;

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var element in widget.basket) {
      total += element.currentCount * element.price;
    }

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
                  title: Text('Order details', style: Styles.titleBoldStyle,),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/img/arrow_back.png', width: Config.iconSize,
                      height: Config.iconSize,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Config.screenBackColor,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(Config.mediumPadding),
                    itemBuilder: (context, index) => BasketPizzaComponent(
                      model: widget.basket[index],
                      updateParentState: () {
                        setState(() {});
                      }
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: Config.largePadding,
                    ),
                    itemCount: widget.basket.length,
                  ),
                ),
              ),

              Container(
                decoration: const BoxDecoration(
                  color: Config.screenBackColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Config.mediumPadding,
                    horizontal: Config.mediumPadding,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: CustomGradient(),
                      borderRadius: BorderRadius.circular(
                        Config.mediumBorderRadius,
                      ),
                    ),
                    padding: EdgeInsets.all(Config.largePadding),
                    child: Column(
                      children: [
                        Divider(
                          color: Config.textColorOnPrimary, thickness: 1,
                          height: 1,
                        ),

                        SizedBox(height: Config.mediumPadding / 2,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Total', style: Styles.textSmallStyle,),

                            Text(r'$' '${total.round()}', style: Styles.textMediumStyle,)
                          ],
                        ),

                        SizedBox(height: Config.mediumPadding,),

                        Container(
                          decoration: BoxDecoration(
                            color: Config.screenBackColor,
                            borderRadius: BorderRadius.circular(
                              Config.largeBorderRadius,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(Config.mediumPadding),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Place my order',
                                  style: Styles.priceMediumStyle,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
