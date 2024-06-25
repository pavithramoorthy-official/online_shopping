import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shopping/constants/firebase_consts.dart';
import 'package:grocery_shopping/models/orders_model.dart';

class OrdersProviders with ChangeNotifier {
  static List<OrdersModel> _orders = [];
  List<OrdersModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrderFromFirebase() async {
    User? user = firebaseAuthObject.currentUser;
    var uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('orderDate', descending: false)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      for (var element in ordersSnapshot.docs) {
        _orders.insert(
            0,
            OrdersModel(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              userName: element.get('userName'),
              price: element.get('price').toString(),
              imageUrl: element.get('imageUrl'),
              quantity: element.get('quantity').toString(),
              orderDate: element.get('orderDate'),
            ));
      }
    });
    notifyListeners();
  }
}
