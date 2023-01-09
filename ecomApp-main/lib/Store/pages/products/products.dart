import 'dart:math';
import 'package:agent/Store/components/product_card.dart';
import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/Store/components/cart_item.dart';
import 'package:agent/Store/components/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCurUserId();
  }
  var curIdUser;
  var curIdcat;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;

  void addCategoryToDB(category) {

    bool addedOrNot = true;
    ref.child('users').onValue.listen((event) {
      final users = event.snapshot.value as Map;
      users.forEach((key, value) {
        final idUser = key;
        print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR${idUser}");

        value.forEach((key, value) {
          print("ARARARARARARAR ${key}");
          if (value['email'] == user.email && addedOrNot) {
            ref.child('users/${idUser}/category').push().set({
              category: "",
            });
            addedOrNot = false;
          }
        });
      });
    });
  }
  getCurUserId() {
    final  snapshot = ref.child('users').onValue.listen((event) {
      final users = event.snapshot.value as Map;
      users.forEach((key, value) {
        final idUser = key;
        final curCat = value['categories'];

        value.forEach((key, value) {
          if (value['email'] == user.email) {
            setState(() {
              curIdUser = idUser;
            });
          }
        });
      });
    });
  }
  getcatId(){
    final snapshot = ref.child('users/${curIdUser}/category').onValue.listen((event){
      final categorys =event.snapshot.value as Map;
      categorys.forEach((key, value) {
        final idcat=key;
        print("}zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz${idcat}");
        setState(() {
          curIdcat= idcat;
        });
      });
      });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: 'Products',
              size: Dimensions.font16,
              weight: FontWeight.w500,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        StreamBuilder(
          stream: FirebaseDatabase.instance.ref().child('users/${curIdUser}/category/${curIdcat}').onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> productsInDb = [];
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
                      (value['Products'] as Map).forEach((key, value) {
                        productsInDb.add(
                        ProductCard(product: Product(
                          colors: randomColors(),
                          cover: value['ProImageUrl'],
                          desc: value['Description'],
                          name: value['NameProduit'],
                          price: value['Price'],
                        ))
                      );
                    });

                    },
                  );
                },
              );
            }
            return GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: Dimensions.cardHeight,
              ),
              children: productsInDb,
            );
          },
        ),


      ],
    );
  }
}

Random random = Random();
List<Color> randomColors() {
  List<Color> colors = [];
  for (var i = 0; i < 5; i++) {
    colors
        .add(Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
  }
  return colors;
}
