import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';



const String myhomepageRoute = '/';
const String myprofileRoute = 'profile';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myhomepageRoute:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('404 Not found')),
            ));
    }
  }
}
class add_category extends StatefulWidget {
  const add_category({Key? key}) : super(key: key);

  @override
  _add_categoryState createState() => _add_categoryState();
}

class _add_categoryState extends State<add_category> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "ADD CATEGORIS",
        home: MyHomePage(),
        onGenerateRoute: Router.generateRoute,
        initialRoute: myhomepageRoute);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo=File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile!.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }
  Future<String> uploadFile() async {
    firebase_storage.UploadTask? uploadTask;
    if (_photo == null) return '';

    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';
    var URL = "";
    try {
      final ref = await firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file');
      uploadTask = ref.putFile(_photo!);
      final snapshot = await uploadTask.whenComplete(() {});

      // URL = await ref.getDownloadURL();
      URL = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }
    return URL;
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

  String nameCategory = "";
  String imgUrl ="";

  String bodyTemp = "";
  var measure;

  var name ,img  ;


  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;
  void add_CategoryToDB(img,name) {


    bool addedOrNot = true;
    ref.child('users').onValue.listen((event) {
      final users = event.snapshot.value as Map;
      users.forEach((key, value) {
        final idUser = key;
        print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR ${idUser}");

        value.forEach((key, value) {
          print("ARARARARARARAR ${key}");
          if (value['email'] == user.email && addedOrNot) {
            ref.child('users/${idUser}/category').push().set({
              'Name':name,
              'Image':img

            });
            addedOrNot = false;
          }
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: const Text("ADD CATEGORY"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topLeft,
              child: Text("Enter your data",
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(

                    onChanged: (value) {
                      nameCategory = value;
                    },
                    focusNode: name,
                    decoration: const InputDecoration(
                        labelText: 'Name Category',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: OutlineInputBorder()),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name Category must contain at least 1 characters';
                      } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                        return 'Name Category cannot contain special characters';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                  Align(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        // padding: EdgeInsets.all(0),
                      ),
                      onPressed: (){},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                  ),

                  Align(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        // padding: EdgeInsets.all(0),
                      ),
                      onPressed: ()async {

                         final img = await uploadFile();
                         add_CategoryToDB(img,nameCategory);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
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
