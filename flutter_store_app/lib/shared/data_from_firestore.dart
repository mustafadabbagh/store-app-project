// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFireStore extends StatefulWidget {
  final String documentId;

   const GetDataFromFireStore({super.key, required this.documentId});

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
final dialogUsernameController = TextEditingController();
final credential = FirebaseAuth.instance.currentUser;
 CollectionReference users = FirebaseFirestore.instance.collection('users');





myDialog(Map data, dynamic myKey){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11) ),
                child: Container(
                  padding: EdgeInsets.all(22),
                 
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                          controller: dialogUsernameController,
                          decoration: InputDecoration(hintText: "${data[myKey]}")),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                users.doc(credential!.uid).update({myKey: dialogUsernameController.text});
                               setState(() {
                                  Navigator.pop(context);
                               });
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(fontSize: 18),
                              )
                              ),
                              TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontSize: 18),
                              )
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
           
          );
                   
}









  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                "Username : ${data['username']}",style: TextStyle(fontSize: 17),
                ),
                  IconButton(
                    onPressed: (){
                   myDialog(data, 'username');
                    },
                     icon:Icon(Icons.edit) 
                     )
                   ],
                 ),
                SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                "Email : ${data['email']}",style: TextStyle(fontSize: 17),),
                IconButton(
                    onPressed: (){
                   myDialog(data, 'email');
                    },
                     icon:Icon(Icons.edit) 
                     )
                   ],
                 ),
                SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                "Password : ${data['pass']}",style: TextStyle(fontSize: 17),),
                IconButton(
                    onPressed: (){
                   myDialog(data, 'pass');
                    },
                     icon:Icon(Icons.edit) 
                     )
                   ],
                 ),
                SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                "Title : ${data['title']}",style: TextStyle(fontSize: 17),),
                IconButton(
                    onPressed: (){
                   myDialog(data, 'title');
                    },
                     icon:Icon(Icons.edit) 
                     )
                   ],
                 ),
                SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                "Age : ${data['age']}",style: TextStyle(fontSize: 17),),
                IconButton(
                    onPressed: (){
                   myDialog(data, 'age');
                    },
                     icon:Icon(Icons.edit) 
                     )
                   ],
                 ),
                SizedBox(height: 10,),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}