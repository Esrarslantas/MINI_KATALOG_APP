import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  final Function(Product)? onAddToCart;

  const DetailScreen({super.key, required this.product, this.onAddToCart});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          80,
        ), // Altta buton için boşluk
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageAssetPath,
                  width: 200,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Yazar: ${product.author}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.star, size: 22, color: Colors.amber.shade700),
                const SizedBox(width: 6),
                Text('${product.rating}', style: const TextStyle(fontSize: 16)),
                const Spacer(),
                const Icon(Icons.menu_book, size: 22, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  '${product.pageCount} sayfa',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Özet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.summary.isNotEmpty
                  ? product.summary
                  : product.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 24),
            Text(
              'Yorumlar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 8),
            product.comments.isNotEmpty
                ? Column(
                    children: product.comments.map((comment) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          comment,
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  )
                : const Text(
                    'Henüz yorum yok.',
                    style: TextStyle(fontSize: 16),
                  ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.teal.shade700,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (widget.onAddToCart != null) {
              widget.onAddToCart!(product);
              final snackBar = SnackBar(
                content: Text('${product.name} sepete eklendi'),
                duration: const Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent.shade700,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Sepete Ekle',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
