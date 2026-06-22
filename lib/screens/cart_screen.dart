import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  final Map<String, int> cartItems;
  final List<Product> allProducts;
  final Function(Product) onAdd;
  final Function(Product) onRemove;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.allProducts,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<String, int> localCartItems;

  @override
  void initState() {
    super.initState();
    localCartItems = Map<String, int>.from(widget.cartItems);
  }

  void increment(Product product) {
    setState(() {
      localCartItems.update(product.id, (qty) => qty + 1, ifAbsent: () => 1);
      widget.onAdd(product);
    });
  }

  void decrement(Product product) {
    setState(() {
      if (localCartItems.containsKey(product.id)) {
        final currentQty = localCartItems[product.id]!;
        if (currentQty > 1) {
          localCartItems[product.id] = currentQty - 1;
          widget.onRemove(product);
        } else {
          localCartItems.remove(product.id);
          widget.onRemove(product);
        }
      }
    });
  }

  double getTotalPrice() {
    double total = 0;
    localCartItems.forEach((productId, qty) {
      final product = widget.allProducts.firstWhere((p) => p.id == productId);
      total += product.price * qty;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (localCartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sepetim'),
          backgroundColor: Colors.teal.shade700,
        ),
        body: const Center(
          child: Text('Sepetinizde ürün yok.', style: TextStyle(fontSize: 18)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: localCartItems.length,
              itemBuilder: (context, index) {
                final productId = localCartItems.keys.elementAt(index);
                final quantity = localCartItems[productId]!;
                final product = widget.allProducts.firstWhere(
                  (p) => p.id == productId,
                );

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.imageAssetPath,
                        width: 55,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${product.price} ₺ x $quantity = ${product.price * quantity} ₺',
                    ),
                    trailing: SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => decrement(product),
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                            ),
                            onPressed: () => increment(product),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Toplam Fiyat:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${getTotalPrice().toStringAsFixed(2)} ₺',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
