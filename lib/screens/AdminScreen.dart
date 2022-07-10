
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Config.dart';
import '../Styles.dart';
import '../component/CustomAppBar.dart';
import '../component/GradientButton.dart';
import '../bloc/admin_bloc/admin_bloc.dart';
import '../component/AddPizzaComponent.dart';
import '../bloc/pizza_count_bloc/pizza_count_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({
    Key? key,
    required this.updateParentData,
  }) : super(key: key);

  final Function updateParentData;

  void _addPizza(AdminBloc adminBloc) {
    adminBloc.add(AddNewPizza());
  }

  void _savePizza(AdminBloc adminBloc) {
    adminBloc.add(SavePizza());
  }

  @override
  Widget build(BuildContext context) {
    final AdminBloc adminBloc = context.read<AdminBloc>();
    final List<Map<String, dynamic>> pizzaModels = adminBloc.pizzaModels;
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
                      onPressed: () {
                        _addPizza(adminBloc);
                      },
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
                child: BlocBuilder<AdminBloc, AdminState>(
                builder: (context, state) {
                  if (state is AdminLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Config.screenBackColor,
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Config.screenBackColor,
                            ),
                            child: ListView.separated(
                              itemCount: pizzaModels.length,
                              padding: EdgeInsets.all(Config.mediumPadding),
                              itemBuilder: (context, index) {
                                final Map<String, dynamic> item = pizzaModels[index];
                                return BlocProvider<PizzaCountBloc>(
                                  create: (context) => PizzaCountBloc(
                                    count: item['model'].count,
                                  ),
                                  child: AddPizzaComponent(
                                    model: item['model'],
                                    nameController: item['name'],
                                    priceController: item['price'],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: Config.largePadding,
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: adminBloc.isSaveActive,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Config.screenBackColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Config.mediumPadding,
                                horizontal: Config.mediumPadding,
                              ),
                              child: GradientButton(
                                borderRadius: Config.mediumBorderRadius,
                                onPressed: () {
                                  _savePizza(adminBloc);
                                },
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
                      ],
                    );
                  }
                },),
              ),

              BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
                if (state is AdminSuccess) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) =>
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text(
                        'Данные успешно сохранены!',
                        style: Styles.textCardStyle,
                      ),
                    ),),
                  );
                } else if (state is AdminError) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) =>
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text(
                        'Произошла ошибка при сохранении данных',
                        style: Styles.textCardStyle,
                      ),
                    ),),
                  );
                }

                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      )
    );
  }
}
