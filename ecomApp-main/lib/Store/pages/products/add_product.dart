/*
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  @override
  TextEditingController nameproduitController  = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  // Node:
  var name, price, description ;

  // to put values:
  var titleIn, descriptionIN,priceIN;
  addProductToDb(title, price, description, size, color, img) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    setState(() {
      ref.child('users/${idUser}/categories/${idCat}/${curCat}').push().set(
        {
          'title': title,
          'price': price,
          'description': description,
          'size': size,
          'color': color,
          'img': img
        },
      );
    });
  }

  List inputs = [];
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child:Text("add product "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 32,
            ),
            TextFormField(
                controller: nameproduitController,
                onChanged: (value) {
                  titleIn = value;
                },
                focusNode: name,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Name Product',
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(price);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null && value.isEmpty == 0) {
                    return 'Please enter Name';
                  }
                  if (value != null &&
                      !RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
                    return 'Please enter valid Title';
                  }
                  return null;
                }),
            TextFormField(
                controller: priceController,
                onChanged: (value) {
                  priceIN = value;
                },
                focusNode: price,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(description);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null && value.isEmpty == 0) {
                    return 'Please enter Price';
                  }
                  return null;
                }),
            TextFormField(
                controller: descriptionController,
                onChanged: (value) {
                  descriptionIN = value;
                },
                focusNode: description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value != null && value.isEmpty == 0) {
                    return 'Please enter Discription';
                  }
                  if (value != null &&
                      !RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
                    return 'Please enter valid Discription';
                  }
                  return null;
                }
            ),

            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color(0xffFDCF09),
                  child: _photo != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _photo!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                // padding: EdgeInsets.all(0),
              ),
              onPressed: () async {
                // context.loaderOverlay.show();
                // setState(() {
                //   isLoading = context.loaderOverlay.visible;
                // });
                final img = await uploadFile();
                await addProductToDb(
                    titleIn, priceIN, descriptionIN, img);
                // context.loaderOverlay.hide();
                // if (isLoading) {
                //   context.loaderOverlay.hide();
                // }
                // setState(() {
                //   isLoading = context.loaderOverlay.visible;
                // });
                Navigator.pop(context);
              },
              child: const Text(
                "Confirmer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
}
*/
