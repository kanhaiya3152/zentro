// src/presentation/home/widgets/product_tile.dart
import 'package:flutter/material.dart';
import 'package:zentro/details_screen.dart';
import 'package:zentro/product_model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.network(product.image, width: 60, fit: BoxFit.cover),
        title: Text(product.title),
        subtitle: Text('₹${product.price}'),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(product: product),
          ),
        ),
      ),
    );
  }
}
