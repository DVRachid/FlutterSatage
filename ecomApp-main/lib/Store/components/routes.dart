import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../main.dart';
import '../pages/singup_login/login.dart';
import '../pages/singup_login/singUp.dart';

var routes = {
  'login': (context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        print(ConnectionState);
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        print(snapshot.error);
        return const Center(
          child: Text('Something went wrong!'),
        );
      } else if (snapshot.hasData) {
        return HomePage();
      } else {
        return MyLogin();
      }
    },
  ),
  'register': (context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return const Center(
          child: Text('Something went wrong!'),
        );
      } else if (snapshot.hasData) {

        return HomePage();
      } else {
        return MyRegister();
      }
    },
  )
};
