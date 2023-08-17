

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_store_app/pages/checkOut.dart';
import 'package:flutter_store_app/pages/details.dart';
import 'package:flutter_store_app/provider/cart.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({super.key});
  

  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return  Row(
            children: [
                 Stack(
                  children: [
                    Positioned(
                      bottom: 22,
                      child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(211, 164, 255, 193),
                              shape: BoxShape.circle),
                          child: Text(
                            classInstancee.selectedProducts.length.toString(),
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOut(),
                  ),
                );
                        }, 
                        icon: Icon(Icons.add_shopping_cart)),
                  ],
                ),
            
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("\$ ${classInstancee.price}"),
              )
            ],
          )

;
  }
}