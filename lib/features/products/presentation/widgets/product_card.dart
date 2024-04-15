import 'package:flutter/material.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _ImageViewer(images: product.images),
          Text(product.title, textAlign: TextAlign.center,),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final List<String> images;

  const _ImageViewer({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: FadeInImage(
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        fit: BoxFit.cover,
        height: 250,
        image: NetworkImage(images.first),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
      ),
    );
  }
}
