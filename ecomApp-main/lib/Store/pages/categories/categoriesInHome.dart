import 'package:agent/Store/pages/pages_out_home.dart';
import 'package:agent/clients/clients.dart';
import 'package:agent/orders/productListItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agent/Store/constants/colors.dart';
import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/Store/components/my_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'add_category.dart';

class Categories extends StatefulWidget {
  Categories({super.key});


  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
getcuridcat(){
  final  snapshot = ref.child('users/${curIdUser}/category').onValue.listen((event) {
    final categorys = event.snapshot.value as Map;
    categorys.forEach((key, value) {
      final idcat = key;
      setState(() {
        curIdcat = idcat;
      });
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Categories',
                size: Dimensions.font16,
                weight: FontWeight.w500,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                    const add_category()));
                },
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          StreamBuilder(
            stream: FirebaseDatabase.instance.ref().child('users/${curIdUser}/category/${curIdcat}').onValue,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final catsInDb = <Widget>[
                CategoryIconText(
                  label: "All",
                  image:
                      "https://firebasestorage.googleapis.com/v0/b/partner-5ff29.appspot.com/o/all.png?alt=media&token=12541abb-d4ac-45e9-bb18-3d1d2b116a9c",
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        PagesOutHome(
                          currentPage: Clients(),
                          title: 'Categories',
                        ),
                      ),
                    );
                  },
                ),
              ];
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
                            CategoryIconText(
                              label: value['Name'],
                              image: value['Image'],
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PagesOutHome(
                                        currentPage: Clients(),
                                        title: value['Name']),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
              return Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: catsInDb,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryIconText extends StatelessWidget {
  const CategoryIconText({
    Key? key,
    required this.label,
    required this.image,
    required this.onClick,
  }) : super(key: key);

  final String label;
  final String image;
  final onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.height40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius8),
              color: AppColors.main.withOpacity(.2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          MyText(
            text: label,
            size: Dimensions.font14,
            color: AppColors.secondary,
          )
        ],
      ),
    );
  }
}
