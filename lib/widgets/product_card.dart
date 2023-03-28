import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productName,
    required this.price,
    this.image,
  }) : super(key: key);

  final String productName;
  final String price;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        constraints: const BoxConstraints(
          maxHeight: 35,
          maxWidth: 35,
        ),
        child: Card(
          elevation: 15,
          shadowColor: Colors.deepOrange[700],
          child: Row(
            children: [
              Text(
                productName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              // Image(image: ''),
              const SizedBox(height: 5),
              Text(
                price,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    height: 10,
                    fontSize: 8,
                    color: Colors.black87,
                    backgroundColor: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
