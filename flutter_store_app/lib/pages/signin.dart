// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/pages/forgot_password.dart';
import 'package:flutter_store_app/pages/register.dart';
import 'package:flutter_store_app/shared/colors.dart';
import 'package:flutter_store_app/shared/constants.dart';
import 'package:flutter_store_app/shared/snackbar.dart';

class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();


  bool isSecure=true;
  bool isLoading=false;

  signin()async{

    setState(() {
      isLoading = true;
    });
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
} on FirebaseAuthException catch (e) {
 showSnackBar(context, "ERROR: ${e.code}");
}
if (!mounted)return;
setState(() {
      isLoading = false;
    });
  }

   @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Sign in"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Email :",
                        suffixIcon:Icon(Icons.email)
                        ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
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
                                  : Icon(Icons.visibility_off)) 
                        ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: ()async {
                     await signin();
                      if (!mounted) return;
                     
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child:  (isLoading)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          :Text(
                      "Sign in",
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                   
                  const SizedBox(
                    height: 33,
                  ),
                  
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ForgotPassword()),
                          );
                    }, 
                    child: Text("Forgot Password?", style: TextStyle(decoration: TextDecoration.underline, fontSize: 20) ,),
                    ),
                 
                  const SizedBox(
                    height: 33,
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Register()),
                          );
                        },
                        child: Text('sign up',
                            style:
                                TextStyle( fontSize: 20,decoration: TextDecoration.underline )),
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
