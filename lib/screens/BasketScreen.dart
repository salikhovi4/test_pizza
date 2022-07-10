import 'package:flutter/material.dart';

import '../Config.dart';
import '../Styles.dart';
import '../Storage.dart';
import '../model/PizzaModel.dart';
import '../component/Gradient.dart';
import '../component/CustomAppBar.dart';
import '../component/BasketPizzaComponent.dart';
import '../component/DismissibleComponent.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({
    Key? key,
    required this.basket,
    required this.updateParentData,
    required this.updateParentState,
  }) : super(key: key);

  final List<PizzaModel> basket;
  final Function updateParentData;
  final Function updateParentState;

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late List<PizzaModel> _basket;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _basket = widget.basket;
  }

  @override
  void didUpdateWidget(covariant BasketScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    _basket = widget.basket;
  }

  Future<void> _makeOrder() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: Config.progressDuration),
        () async {
      for (PizzaModel model in _basket) {
        int rest = model.quantity - model.count;
        if (rest <= 0) {
          await Storage.remove(model.name, 'id');
          await Storage.remove(model.name, 'quantity');
          await Storage.remove(model.name, 'price');
          await Storage.remove(model.name, 'imagePath');
        } else {
          await Storage.setInt(
              name: model.name, field: 'quantity', value: rest);
        }
      }
    });

    _basket.clear();

    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Ваш заказ обрабатывается!',
                style: Styles.textCardStyle,
              ),
            ));

    widget.updateParentData();
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var element in widget.basket) {
      total += element.count * element.price;
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
                  title: Text(
                    'Order details',
                    style: Styles.titleBoldStyle,
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      widget.updateParentState();
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/img/arrow_back.png',
                      width: Config.iconSize,
                      height: Config.iconSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Config.screenBackColor,
                        ),
                        child: _basket.isNotEmpty
                            ? ListView.separated(
                                padding: EdgeInsets.all(Config.mediumPadding),
                                itemBuilder: (context, index) {
                                  PizzaModel model = _basket[index];
                                  return DismissibleComponent(
                                    onDismissed: (DismissDirection direction) {
                                      if (_basket.contains(model)) {
                                        _basket.remove(model);
                                      }
                                      setState(() {});
                                    },
                                    borderRadius: Config.mediumBorderRadius,
                                    child: BasketPizzaComponent(
                                        model: model,
                                        updateParentState: () {
                                          setState(() {});
                                        }),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: Config.largePadding,
                                ),
                                itemCount: _basket.length,
                              )
                            : Center(
                                child: Text(
                                  'Корзина пуста',
                                  style: Styles.titleStyle,
                                ),
                              ),
                      ),
              ),
              _basket.isNotEmpty
                  ? Container(
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
                                color: Config.textColorOnPrimary,
                                thickness: 1,
                                height: 1,
                              ),
                              SizedBox(
                                height: Config.mediumPadding / 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total',
                                    style: Styles.textSmallStyle,
                                  ),
                                  Text(
                                    r'$' '${total.round()}',
                                    style: Styles.textMediumStyle,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Config.mediumPadding,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Config.screenBackColor,
                                  borderRadius: BorderRadius.circular(
                                    Config.largeBorderRadius,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: _makeOrder,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.all(Config.mediumPadding),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Place my order',
                                          style: Styles.priceMediumStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
