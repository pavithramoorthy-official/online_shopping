import 'package:flutter/material.dart';
import 'package:grocery_shopping/models/wishlist_model.dart';

class WishlistProviders with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addProductToWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      removeOneWishlistItem(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeOneWishlistItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
