import 'package:flutter/material.dart';
import 'package:zentro/product_model.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, 
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.35, 
                    width: double.infinity,
                    child: Image.network(product.image, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02), 
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[800],
                    ),
                  ),

                  SizedBox(height: screenWidth * 0.03), 
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.green,
                        size: screenWidth * 0.05, 
                      ),
                      Text(
                        "${product.rating.rate}(${product.rating.count})",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.03), 
                  Row(
                    children: [
                      Text(
                        "₹${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, 
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}