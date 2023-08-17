// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_store_app/model/product.dart';
import 'package:flutter_store_app/pages/home.dart';
import 'package:flutter_store_app/provider/cart.dart';
import 'package:flutter_store_app/shared/appbar.dart';
import 'package:flutter_store_app/shared/colors.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Checkout"),
        actions: [ProductsAndPrice()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classInstancee.productCount,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        subtitle: Text(
                            "\$ ${classInstancee.selectedProducts[index].shirtPrice.toString()}"),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              classInstancee.selectedProducts[index].clubShirt),
                        ),
                        title:
                            Text(classInstancee.selectedProducts[index].club),
                        trailing: IconButton(
                            onPressed: () {
                             setState(() {
                                classInstancee.delete(classInstancee.selectedProducts[index]);
                             });
                            }, icon: Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
            (classInstancee.price == 0)
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNpink),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Go to home screen",
                      style: TextStyle(fontSize: 19),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Pay  \$ ${classInstancee.price}",
                      style: TextStyle(fontSize: 19),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
