import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/components/appbar.dart';
import 'package:agent/components/rightMenu.dart';
import 'package:flutter/material.dart';

class PagesOutHome extends StatelessWidget {
  final Widget currentPage;
  final String title;
  const PagesOutHome({Key? key, required this.currentPage, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: kredaAppBar(false, title, context),
      endDrawer: rightMenu(divider: divider),
      body: currentPage,
    );
  }
}
