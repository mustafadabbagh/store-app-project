// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_store_app/model/product.dart';
import 'package:flutter_store_app/shared/appbar.dart';
import 'package:flutter_store_app/shared/colors.dart';

class Details extends StatefulWidget {
    Products item ;
    Details ({super.key,  required this.item });
 

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool textstate = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text("Details"),
          actions: [
          ProductsAndPrice()
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.item.clubShirt,
                  height: 300,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("\$39.99", style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Text("New", style: TextStyle(fontSize: 15)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color.fromARGB(255, 209, 72, 63)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 25,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 25,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 25,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 25,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit_location,
                          size: 25,
                          color: const Color.fromARGB(255, 20, 83, 23),
                        ),
                        Text("Mustafa store", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Details :",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.item.shirtDetails,
                  style: TextStyle(fontSize: 20),
                  maxLines: textstate ? 3 : null,
                  overflow: TextOverflow.fade,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      textstate = !textstate;
                    }); 
                  },
                  child: Text(textstate ? "show more" : "show less",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
