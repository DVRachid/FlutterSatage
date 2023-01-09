import 'package:agent/orders/productListItem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('users').onValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List ordersInDb = [];
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data.snapshot.value != null) {
          final mapOfResult = Map<String, dynamic>.from(
              (snapshot.data! as DatabaseEvent).snapshot.value as Map);
          mapOfResult.forEach((key, value) {
            Map CategoryInDb = value['Orders'];
            CategoryInDb.forEach((key, value) {
              Map order = value;
              // setState(() {
              String Status = value['Status'];
              // });
              Map product = value['produit'];
              Map client = value['client'];
              Map category = value['category'];
              ordersInDb.add(ProductItem(
                id: value['id'],
                productName: product['NameProduit'],
                client: client['LastName'] + ' ' + client['FirstName'],
                imageUrl: product['ProImageUrl'],
                productPrice: product['Price'],
                status: Status,
                totalPrice: value['totalPrice'],
                amount: value['qte'].toString(),
              ));
            });
          });
        }

        List<Widget> resultOfProd = [];

        List twoPerRow = [];

        for (var i = 0; i < ordersInDb.length; i += 2) {
          twoPerRow.add(ordersInDb.sublist(
              i, i + 2 > ordersInDb.length ? ordersInDb.length : i + 2));
        }
        for (var i = 0; i < twoPerRow.length; i += 1) {
          if (twoPerRow[i].asMap().containsKey(1)) {
            // 2 exist
            resultOfProd.add(ProductsListItem(
                firstProduct: twoPerRow[i][0], secondProduct: twoPerRow[i][1]));
          } else {
            // only one exist 1
            resultOfProd.add(ProductsListItem(firstProduct: twoPerRow[i][0]));
          }
        }

        return ListView(
          children: resultOfProd,
        );
      },
    );
  }
}
