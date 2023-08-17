// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/model/product.dart';
import 'package:flutter_store_app/pages/checkOut.dart';
import 'package:flutter_store_app/pages/details.dart';
import 'package:flutter_store_app/pages/profile_page.dart';
import 'package:flutter_store_app/provider/cart.dart';
import 'package:flutter_store_app/shared/appbar.dart';
import 'package:flutter_store_app/shared/colors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/nature.jpg"),
                        fit: BoxFit.cover),
                  ),
                  accountName: Text("Mustafa Dabbagh",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  accountEmail: Text("mustafadabbagh@gmail.com"),
                  currentAccountPictureSize: Size.square(99),
                  currentAccountPicture: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/mustafa_pic.jpg")),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                       Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckOut(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                    ListTile(
                    title: Text("My profile"),
                    leading: Icon(Icons.person),
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    }),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    }),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text("Developed by Mustafa Safi © 2024",
                  style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Home"),
        actions: [
     
      ProductsAndPrice()
      
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20),
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      item: item[index],
                    ),
                  ),
                );
              },
              child: GridTile(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        item[index].clubShirt,
                      ),
                    )
                  ],
                ),
                footer: GridTileBar(
                  trailing: 
                     IconButton(
                        color: Color.fromARGB(255, 62, 94, 70),
                        onPressed: () {
                          setState(() {
                            classInstancee.add(item[index]);
                        
                          });
                        },
                        icon: Icon(Icons.add)),
                 
                  leading: Text(item[index].shirtPrice.toString()),
                  title: Text(
                    "",
                  ),
                ),
              ),
            );
          }),
    );
  }
}
