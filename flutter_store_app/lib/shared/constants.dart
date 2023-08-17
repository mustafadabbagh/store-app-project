
import 'package:flutter/material.dart';


const decorationTextField = InputDecoration(
              
              // To delete borders
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 25, 129, 25),),),
              // fillColor: Colors.red,
              filled: true,
              contentPadding: EdgeInsets.all(8),
            );