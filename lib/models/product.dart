class Product {
  final String id;
  final String name;
  final String author;
  final String description;
  final int price;
  final String imageAssetPath;

  final double rating; // Yeni: puan
  final int pageCount; // Yeni: sayfa sayısı
  final String summary; // Yeni: özet
  final List<String> comments; // Yeni: yorumlar

  const Product({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.price,
    required this.imageAssetPath,
    this.rating = 0.0,
    this.pageCount = 0,
    this.summary = '',
    this.comments = const [],
  });
}
