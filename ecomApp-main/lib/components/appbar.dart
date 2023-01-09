import 'package:agent/constants/constants.dart';
import 'package:agent/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var kredaAppBar = (bool isHomePage, String title, context) {
  return isHomePage
      ? AppBar(
          title: const Text("Kreda Agent"),
          // backgroundColor: const Color.fromARGB(255, 110, 203, 215),
          backgroundColor: secondarycolor,
          elevation: 5.0,
          bottom: TabBar(
            onTap: (index) {},
            tabs: const [
              Tab(icon: Icon(Icons.store_mall_directory)),
              Tab(icon: Icon(Icons.receipt_long)),
              Tab(icon: Icon(Icons.category)),
              Tab(icon: Icon(Icons.people)),
            ],
          ),
        )
      : AppBar(
          title: Text(title),
          // backgroundColor: const Color.fromARGB(255, 110, 203, 215),
          backgroundColor: const Color(0xFF9DA2AE),
          elevation: 5.0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            },
          ),
        );
};
