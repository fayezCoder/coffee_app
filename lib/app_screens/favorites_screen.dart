// ignore_for_file: prefer_const_constructors

import 'package:coffee_express/global_helpers/global_colors.dart';
import 'package:coffee_express/global_helpers/global_fonts.dart';
import 'package:coffee_express/reusable_widgets/favorite_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx_controllers/cart_controller.dart';
import '../getx_controllers/favorites_controller.dart';

final controller = Get.put(FavoriteController());
final cartController = Get.put(CartController());

double offSetValue = 10;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.favourites.keys.toList().length == 0) {
      return emptyFavs();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 46),
        child: Column(
          children: [
            Spacer(),
            Text(
              'Favorites',
              style: TextStyle(
                color: Colors.white,
                fontFamily: mainFont,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 540,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Dismissible(
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        setState(() {
                          controller.favourites.remove(
                              controller.favourites.keys.toList()[index]);
                        });
                      } else if (direction == DismissDirection.startToEnd) {
                        setState(() {
                          cartController.addProduct(
                              controller.favourites.keys.toList()[index]);
                        });
                      }
                    },
                    background: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(
                          CupertinoIcons.cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          CupertinoIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    child: FavoriteItem(
                        controller: cartController,
                        item: controller.favourites.keys.toList()[index]),
                  ),
                )),
                itemCount: controller.favourites.length,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget emptyFavs() {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 18, right: 18),
          child: Column(
            children: [
              Text(
                'Favorites',
                style: TextStyle(
                    fontSize: 24, fontFamily: mainFont, color: Colors.white),
              ),
              SizedBox(
                width: 115,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: animationController.view,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, animationController.value * 20),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/icon.png',
                        width: 250,
                        height: 200,
                      ),
                    ),
                    Text(
                      'No items currently in favorites',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: mainFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
