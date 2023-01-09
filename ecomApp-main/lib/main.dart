import 'dart:io';
import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/Store/pages/index.dart';
import 'package:agent/clients/clients.dart';
import 'package:agent/components/appbar.dart';
import 'package:agent/components/rightMenu.dart';
import 'package:agent/http/httpOverides.dart';
import 'package:agent/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Store/components/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'login',
          routes: routes,

        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primarycolor,
      appBar: kredaAppBar(true, 'Kreda Partner', context),
      endDrawer: rightMenu(divider: divider),
      body: TabBarView(children: [
        Our_Pro_Cat(),
        Orders(),
        const Center(child: Text("Home")),
        Clients()
      ]),
    );
  }
}
