import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shopping/providers/wishlist_providers.dart';
import 'package:grocery_shopping/services/utilities.dart';
import 'package:provider/provider.dart';

class HeartIconWidget extends StatelessWidget {
  const HeartIconWidget({
    super.key,
    required this.productId,
    this.isInWishlist = false,
  });
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    Color color = Utilities(context).color;
    final wishlistProvidersObject = Provider.of<WishlistProviders>(context);

    return GestureDetector(
      onTap: () {
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
