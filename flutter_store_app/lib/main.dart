// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/pages/home.dart';
import 'package:flutter_store_app/pages/signin.dart';
import 'package:flutter_store_app/provider/cart.dart';
import 'package:flutter_store_app/shared/snackbar.dart';
import 'package:provider/provider.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
 void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await Firebase.initializeApp(
         options: const FirebaseOptions(
           apiKey: "AIzaSyBNa5O87Nl0GeHGe4bCdPe_R1-8TDsA-eE",
           authDomain: "t-shirts-application.firebaseapp.com",
           projectId: "t-shirts-application",
           storageBucket: "t-shirts-application.appspot.com",
           messagingSenderId: "833648452944",
           appId: "1:833648452944:web:4fd8bc95c78d988c9db855"));
  } else {
 await Firebase.initializeApp();
  }
 runApp(const MyApp());
 }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child:  MaterialApp(
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.white,));
              } 
            else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
              }
            else if (snapshot.hasData) {
              // return VerifyEmailPage();
              return Home();

              }
             else {return Login();}
          }
          )
          ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
