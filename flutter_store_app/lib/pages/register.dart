// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/pages/signin.dart';
import 'package:flutter_store_app/shared/colors.dart';
import 'package:flutter_store_app/shared/constants.dart';
import 'package:flutter_store_app/shared/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isSecure = true;

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool has8Char = false;
  bool hasNumber = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialChar = false;


  File? imgPath;


  uploadImageToScreen() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);});
    } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}
      }









  onPasswordChanged(String password) {
    has8Char = false;
    hasNumber = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialChar = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        has8Char = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasNumber = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialChar = true;
      }
    });
  }

  rigester() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users
          .doc(credential.user!.uid)
          .set({
            "username": usernameController.text,
            "age": ageController.text,
            "title": titleController.text,
            "email": emailController.text,
            "pass": passwordController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Try again later.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    titleController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    (imgPath == null)
                   ? CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 255, 253, 253),
                      radius: 64,
                      backgroundImage: AssetImage("assets/avatar.png"),
                    ) 
                    :ClipOval(
                      child: Image.file(imgPath!,height: 145,width: 145,fit: BoxFit.cover,)
                      ),
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () {
                    uploadImageToScreen();
                      }, 
                      icon: Icon(Icons.add_a_photo)
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Username :",
                        suffixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your age :",
                        suffixIcon: Icon(Icons.apps_outage)),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your title :",
                        suffixIcon: Icon(Icons.person_outlined)),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    validator: (email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Email :",
                        suffixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: (isSecure) ? true : false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your password :",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isSecure = !isSecure;
                              });
                            },
                            icon: (isSecure)
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off))),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            shape: BoxShape.circle,
                            color: has8Char ? Colors.green : Colors.white),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("has at least 8 charecters")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            shape: BoxShape.circle,
                            color: hasNumber ? Colors.green : Colors.white),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("has at least 1 number")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            shape: BoxShape.circle,
                            color: hasUppercase ? Colors.green : Colors.white),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("has uppercase")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            shape: BoxShape.circle,
                            color: hasLowercase ? Colors.green : Colors.white),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("hase lower case")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                            shape: BoxShape.circle,
                            color:
                                hasSpecialChar ? Colors.green : Colors.white),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("has special character")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await rigester();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } else {
                        showSnackBar(context, "ERROR");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: (isLoading)
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Register",
                            style: TextStyle(fontSize: 23),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text('sign in',
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
