
import 'package:flutter/material.dart';
import 'package:pizza/Config.dart';
import 'package:pizza/Styles.dart';
import 'package:pizza/component/CustomAppBar.dart';
import 'package:pizza/component/GradientMask.dart';
import 'package:pizza/screens/AdminScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config.mediumPadding),
          child: Column(
            children: [
              CustomAppBar(
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

              Expanded(child: Text('')),
            ],
          ),
        ),
      ),
    );
  }
}
