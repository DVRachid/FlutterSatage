import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agent/Store/pages/categories/categoriesInHome.dart';
import 'package:agent/Store/pages/products/products.dart';
import '../constants/dimesions.dart';

class Our_Pro_Cat extends StatelessWidget {
  Our_Pro_Cat({super.key});
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: Dimensions.width20,
          left: Dimensions.width20,
          top: Dimensions.height10,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Categories(),
              Products(),
            ],
          ),
        ),
      ),
    );
  }
}
