import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

const String userId = 'id_1';

updateStatus(orderId, newStatus) async {
  final ref = FirebaseDatabase.instance.ref();
  await ref
      .child('users/$userId/Orders/$orderId')
      .update({'Status': newStatus});
}

class ProductItem {
  final String id;
  final String productName;
  final String totalPrice;
  final String productPrice;
  final String client;
  final String imageUrl;
  final String status;
  final String amount;
  const ProductItem(
      {Key? key,
      required this.id,
      required this.productName,
      required this.totalPrice,
      required this.productPrice,
      required this.client,
      required this.imageUrl,
      required this.status,
      required this.amount});
}

class ProductsListItem extends StatefulWidget {
  final ProductItem firstProduct;
  final ProductItem? secondProduct;

  const ProductsListItem(
      {super.key, required this.firstProduct, this.secondProduct});

  @override
  State<ProductsListItem> createState() => _ProductsListItemState();
}

class _ProductsListItemState extends State<ProductsListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.secondProduct != null
          ? <Widget>[
              _buildProductItemCard(context, widget.firstProduct),
              _buildProductItemCard(context, widget.secondProduct),
            ]
          : <Widget>[
              _buildProductItemCard(context, widget.firstProduct),
            ],
    );
  }

  _buildProductItemCard(BuildContext context, ProductItem? prod) {
    var status = prod!.status;
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width / 2.2,
              child: Image.network(
                prod!.imageUrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    prod!.productName,
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        prod!.totalPrice,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        prod!.amount,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        prod.productPrice,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(prod!.client),
                    ],
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  DropdownButton<String>(
                    value: status,
                    items: ['Pending', 'Processing', 'Delivered', 'Cancelled']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        updateStatus(prod.id, newValue);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
