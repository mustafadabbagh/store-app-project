// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/shared/colors.dart';
import 'package:flutter_store_app/shared/constants.dart';
import 'package:flutter_store_app/shared/snackbar.dart';

class ForgotPassword extends StatefulWidget {
   const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final emailController = TextEditingController();
     final _formKey = GlobalKey<FormState>();
     bool isLoading= false;





resetPassword()async{

setState(() {
      isLoading = true;
    });

  try {
     await FirebaseAuth.instance
    .sendPasswordResetEmail(email:emailController.text);
    if (!mounted)return;
    showSnackBar(context, "Done - please check your email");
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
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Forgot password"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key:_formKey ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Entre your email to reset password", style: TextStyle(fontSize: 20)
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
                  ElevatedButton(
                      onPressed: ()async {
                        if (_formKey.currentState!.validate()) {
                         resetPassword();
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
                              "Reset password",
                              style: TextStyle(fontSize: 23),
                            ),
                    ),      
              ],
            ),
          ),
        ),
      ),
    );
  }
}