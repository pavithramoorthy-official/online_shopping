import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/constants/firebase_consts.dart';
import 'package:grocery_shopping/providers/product_providers.dart';
import 'package:grocery_shopping/providers/wishlist_providers.dart';
import 'package:grocery_shopping/services/global_methods.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:provider/provider.dart';

class HeartIconWidget extends StatelessWidget {
  HeartIconWidget({
    super.key,
    required this.productId,
    this.isInWishlist = false,
  });
  final String productId;
  final bool? isInWishlist;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Color color = Utilities(context).color;
    final productProviders = Provider.of<ProductProviders>(context);
    final getCurrentProduct = productProviders.findProductbyId(productId);
    final wishlistProvidersObject = Provider.of<WishlistProviders>(context);

    return GestureDetector(
      onTap: () async {
        final User? user = firebaseAuthObject.currentUser;
        if (user == null) {
          GlobalMethods.errorDialogue(
              subtitle: "Please Login to Continue", context: context);
          return;
        }
        wishlistProvidersObject.addProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
            isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
