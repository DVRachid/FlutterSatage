import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/Store/pages/index.dart';
import 'package:agent/Store/pages/pages_out_home.dart';
import 'package:agent/clients/clients.dart';
import 'package:agent/constants/constants.dart';
import 'package:agent/orders/orders.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class rightMenu extends StatelessWidget {
  const rightMenu({
    Key? key,
    required this.divider,
  }) : super(key: key);

  final Divider divider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 5),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: secondarycolor,
            ),
            //Title of header
            child: StreamBuilder(
                stream: FirebaseDatabase.instance.ref().child('users').onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Widget> userInfos = [];
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    final mapOfResult = Map<String, dynamic>.from(
                        (snapshot.data! as DatabaseEvent).snapshot.value
                            as Map);
                    mapOfResult.forEach((key, value) {
                      userInfos.addAll([
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value['Name'],
                              style: const TextStyle(
                                  fontSize: 26, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {

                              },
                              icon: const Icon(Icons.logout),
                            ),
                          ],
                        ),
                        Container(
                          height: Dimensions.height100,
                          width: Dimensions.width100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(value['ProfileImageUrl']),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ]);
                    });
                  }
                  return Column(children: userInfos);
                }),
          ),
          ListTile(
            title: const Text('store'),
            leading: const Icon(Icons.store_mall_directory),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PagesOutHome(currentPage: Our_Pro_Cat(), title: 'Store'),
                ),
              );
            },
          ),
          divider,
          ListTile(
            title: const Text('Orders'),
            leading: const Icon(Icons.receipt_long),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PagesOutHome(
                      currentPage: Orders(),
                      title: 'Orders'),
                ),
              );
            },
          ),
          divider,
          ListTile(
            title: const Text('Categories'),
            leading: Icon(Icons.category),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PagesOutHome(
                        currentPage:  DEMO(
                          txt: 'Categories',
                        ),
                        title: 'Categories'),
                  ));
            },
          ),
          divider,
          ListTile(
            title: const Text('Clients'),
            leading: const Icon(Icons.people),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PagesOutHome(
                      currentPage: Clients(),
                      title: 'Clients'),));
            },
          ),
        ],
      ),
    );
  }
}

class DEMO extends StatelessWidget {
  final String txt;
  const DEMO({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(txt)),
    );
  }
}
