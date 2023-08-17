   



   





import 'package:flutter/material.dart';
import 'package:flutter_store_app/model/product.dart';


class Cart with ChangeNotifier{
  List selectedProducts=[];
  double price = 0;

  add(Products item){
    selectedProducts.add(item);
    price+=item.shirtPrice.round();
    notifyListeners();
  }

  
  delete(Products item){
   selectedProducts.remove(item);
    price-=item.shirtPrice.round();
    notifyListeners();
  }

  get productCount{
   return selectedProducts.length;
  }

}