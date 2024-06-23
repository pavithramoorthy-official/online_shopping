import 'package:admin_panel/inner_screens/edit_products.dart';
import 'package:admin_panel/services/global_methods.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = false;
  String title = '';
  String productCategory = '';
  String? imageUrl = '';
  String price = '';
  String salePrice = '0';
  bool isOnSale = false;
  bool isPiece = false;

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  Future<void> getUserDetail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .get();

      // _name = userDoc.get('name');
      title = productsDoc.get('title');
      productCategory = productsDoc.get('productCategory');
      imageUrl = productsDoc.get('imageUrl');
      price = productsDoc.get('price');
      salePrice = productsDoc.get('salePrice');
      isOnSale = productsDoc.get('isOnSale');
      isPiece = productsDoc.get('isPiece');
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      GlobalMethods.errorDialogue(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utilities(context).getScreenSize;
    Color color = Utilities(context).color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => EditProductForm(
                      id: widget.id,
                      title: title,
                      price: price,
                      productCategory: productCategory,
                      isOnSale: isOnSale,
                      isPiece: isPiece,
                      salePrice: salePrice.toString(),
                      imageUrl:
                          imageUrl == null ? 'Error fetching Image' : imageUrl!,
                    )),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Image.network(
                        imageUrl ??
                            'https://www.lifepng.com/wp-content/uploads/2020/11/Apricot-Large-Single-png-hd.png',
                        fit: BoxFit.fill,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: const Text("Edit"),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ])
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale
                          //? "Rs ${salePrice.toStringAsFixed(2)}"
                          ? "Rs $salePrice"
                          : "Rs $price",
                      color: color,
                      textSize: 12,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                      visible: isOnSale,
                      child: Text("Rs $price",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color,
                              fontSize: 12)),
                    ),
                    const Spacer(),
                    TextWidget(
                      text: isPiece ? "1 Piece" : "1 Kg",
                      color: color,
                      textSize: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
