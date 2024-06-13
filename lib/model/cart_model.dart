import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "100.00", "lib/images/avocado.png", Colors.green],
    ["Banana", "40.00", "lib/images/banana.png", Colors.yellow],
    ["Country Chicken", "280.00", "lib/images/chicken.png", Colors.brown],
    ["Water", "20.00", "lib/images/water.png", Colors.blue],
    ["Red Chilli", "190.00", "lib/images/spice.png", Colors.red],
    ["Rice", "4000.00", "lib/images/rice.png", Colors.yellow],
    ["Turmeric", "192.00", "lib/images/turmeric.png", Colors.orange],
    ["Mango", "50.00", "lib/images/mango.png", Colors.yellow],
    ["Wheat flour", "55.00", "lib/images/flour.png", Colors.yellow],
    ["Corn", "20.00", "lib/images/corn.png", Colors.orange],
  ];

  // list of cart items
  List _cartItems = [];

  List get cartItems => _cartItems;

  List get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
