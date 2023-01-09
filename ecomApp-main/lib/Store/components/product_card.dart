import 'package:agent/Store/components/cart_item.dart';
import 'package:agent/Store/constants/colors.dart';
import 'package:agent/Store/constants/dimesions.dart';
import 'package:agent/Store/components/my_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius8),
            topRight: Radius.circular(Dimensions.radius8),
          ),
        ),
        elevation: .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius8),
                topRight: Radius.circular(Dimensions.radius8),
              ),
              child: Image.network(
                product.cover,
                height: Dimensions.coverHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width15, top: Dimensions.height10),
              child: MyText(
                text: product.name,
                size: 14,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width15,
                top: Dimensions.height5,
                bottom: Dimensions.height15,
              ),
              child: MyText(
                text: product.price,
                size: 15,
                weight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                width: double.infinity,
                height: Dimensions.height45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.main),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Add to cart',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
