import 'package:agent/Store/pages/categories/LongCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class allcategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('users').onValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> catsInDb = [];

        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          final mapOfResult = Map<String, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value as Map);
          mapOfResult.forEach(
            (key, value) {
              Map CategoryInDb = value['category'];
              CategoryInDb.forEach(
                (key, value) {
                  if (catsInDb.length < 5) {
                    catsInDb.add(
                      Column(
                        children: [
                          longCard(label: value['Name'], image: value['Image']),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          );
        }

        return Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 24),
              height: size.height / 4,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(34)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: catsInDb,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
      },
    );
  }
}
