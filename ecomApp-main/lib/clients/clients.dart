import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Clients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('Client').onValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> clientsInDb = [];
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          final mapOfResult = Map<String, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value as Map);
          mapOfResult.forEach((key, value) {
            clientsInDb.addAll([
              Card(
                color: Colors.grey[300],
                elevation: 8.0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50, 
                              backgroundImage: NetworkImage(value['image']),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  width: 150,
                                  color: Colors.black54,
                                  height: 2,
                                ),
                                const SizedBox(height: 4),
                                Text("${value['PhoneNumber']}"),
                                const Text('Chelsea City'),
                                const Text('Flutteria'),
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${value['LastName']} ${value['FirstName']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    "${value['LastName'][0]}. ${value['FirstName']}"),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'Mobile App Developer',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('FlutterStars Inc'),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]);
          
          });
        }
        return ListView(
          children: clientsInDb,
        );
      },
    );

    // <== The Card class constructor
  }
}
