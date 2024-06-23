import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/product_widget.dart';
import 'package:admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMain = true,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;

  @override
  Widget build(BuildContext context) {
    final Color color = Utilities(context).color;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: isInMain && snapshot.data!.docs.length > 4
                  ? 4
                  : snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
              ),
              itemBuilder: (context, index) {
                return ProductWidget(
                  id: snapshot.data!.docs[index]['id'],
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text("Your Store is Empty"),
              ),
            );
          }
        }
        return const Center(
          child: Text(
            "Something Went Wrong",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        );
      },
    );
  }
}
