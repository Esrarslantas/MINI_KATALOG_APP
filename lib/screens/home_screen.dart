import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> allProducts = const [
    Product(
      id: '1',
      name: 'Yedi Güzel Adam',
      author: 'Cahit Zarifoğlu',
      description: 'Türk edebiyatının önemli eserlerinden.',
      price: 45,
      imageAssetPath: 'assets/images/yedigüzeladam.jpeg',
      rating: 4.7,
      pageCount: 140,
      summary:
          'İlk Basım Tarihi: 01.06.2022\nBaskı Sayısı: 1\nTürü: Şiir\nCilt Bilgisi: Amerikan Cilt - Bristol Kapak\nKağıt Bilgisi: Kitap Kağıdı\nBoyut: 13.5x21 cm\n\nYedi Güzel Adam - Cahit Zarifoğlu\nHayret ve varolma tıkandı\nHayret ve hayâ tıkandı\nHayret ve hayret ve hayret\nİlk kez geriye dönmek gerekiyor\n\nDağları yokladınız mı dilsiz duranları\nBir de kulak kesilince\nDağ konuşur - Hayır konuşmaz mı',
      comments: [
        'Harika bir eser, özellikle şiir severlere tavsiye ederim.',
        'Duygusal ve samimi bir anlatımı var.',
        'Klasik Türkiye edebiyatını tanımak için çok güzel bir kaynak.',
      ],
    ),
    Product(
      id: '2',
      name: 'İnsan Neyle Yaşar?',
      author: 'Tolstoy',
      description: 'Tolstoy’un insanlık üzerine kısa hikayeleri.',
      price: 39,
      imageAssetPath:
          'assets/images/insan-neyle-yasar-is-bankasi-yayinlari.webp',
      rating: 4.3,
      pageCount: 101,
      summary:
          'Baskı Sayısı: 6\nTürü: Rus edebiyatı\nCilt Bilgisi: Karton Kapak\nKağıt Bilgisi: Kitap Kağıdı\nBoyut: 13.5x21 cm\n\nLev Nikolayeviç Tolstoy (1828-1910): Anna Karenina, Savaş ve Barış, Kreutzer Sonat ve Diriliş’in büyük yazarı, yaşamının son otuz yılında kendini insan, aile, din, devlet, toplum, özgürlük, boyun eğme, başkaldırma, sanat ve estetik konularında kuramsal çalışmalara verdi. Bu dönemde yazdığı öykülerde yıllarca üzerinde düşündüğü insanlık sorunlarını edebi bir kurgu içinde ele aldı. Tolstoy, insan sevgisi ve inanç konularını ustalığının bütün inceliğiyle işlerken, İnsan Neyle Yaşar? ile gerçek hayatı yansıtan tabloların içinde yeni bir ahlak anlayışını ortaya koydu.',
      comments: [
        'Tolstoy’un en anlamlı eserlerinden biri.',
        'İnsana dair derin düşünceler barındırıyor.',
      ],
    ),
    Product(
      id: '3',
      name: 'Suç ve Ceza',
      author: 'Dostoyevski',
      description: 'Psikolojik derinliğe sahip klasik roman.',
      price: 60,
      imageAssetPath:
          'assets/images/suc-ve-ceza-fyodor-mihaylovic-dostoyevski-z.avif',
    ),
    Product(
      id: '4',
      name: 'Emma',
      author: 'Jane Austen',
      description: 'Romantik dönem İngiliz edebiyatı eseri.',
      price: 50,
      imageAssetPath: 'assets/images/emma.jpg',
    ),
    Product(
      id: '5',
      name: 'Çiçek Senfonisi',
      author: 'Özdemir Asaf',
      description: 'Şiirlerle dolu duygusal bir eser.',
      price: 33,
      imageAssetPath: 'assets/images/çiçeksenfonisi.jpg',
    ),
    Product(
      id: '6',
      name: 'Yaşamak',
      author: 'Cahit Zarifoğlu',
      description: 'Yaşam üzerine güzel düşünceler içeren eser.',
      price: 40,
      imageAssetPath: 'assets/images/yaşamak.jpg',
    ),
  ];

  List<Product> displayedProducts = [];
  Map<String, int> cartItems = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedProducts = allProducts;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        displayedProducts = allProducts;
      } else {
        displayedProducts = allProducts.where((product) {
          final nameLower = product.name.toLowerCase();
          final authorLower = product.author.toLowerCase();
          return nameLower.contains(query) || authorLower.contains(query);
        }).toList();
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.update(
        product.id,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      if (cartItems.containsKey(product.id)) {
        final currentQty = cartItems[product.id]!;
        if (currentQty > 1) {
          cartItems[product.id] = currentQty - 1;
        } else {
          cartItems.remove(product.id);
        }
      }
    });
  }

  int getProductQuantity(Product product) {
    return cartItems[product.id] ?? 0;
  }

  int getTotalItems() {
    return cartItems.values.fold(0, (sum, qty) => sum + qty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: const Text('Book Store'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: InkWell(
                onTap: () {
                  // Sepet sayfasına geçiş
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: cartItems,
                        allProducts: allProducts,
                        onAdd: addToCart,
                        onRemove: removeFromCart,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart),
                    const SizedBox(width: 5),
                    Text(
                      '${getTotalItems()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Image.network(
              'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=1350&q=80',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.broken_image, size: 50));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Kitap veya yazar ara...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: displayedProducts.isEmpty
                ? const Center(child: Text("Kitap bulunamadı."))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: displayedProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  product: product,
                                  onAddToCart: addToCart,
                                ),
                              ),
                            );
                          },
                          quantity: getProductQuantity(product),
                          onAdd: () => addToCart(product),
                          onRemove: () => removeFromCart(product),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
