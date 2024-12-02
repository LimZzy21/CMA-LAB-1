class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String currency;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.currency,
  });

  // Фабричний метод для створення об'єкта з JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? 'No name',  // Перевірка на null
      description: json['description'] ?? 'No description',  // Перевірка на null
      price: (json['price'] ?? 0).toDouble(),  // Перевірка на null
      imageUrl: json['image_url'] ?? '',  // Перевірка на null
      rating: (json['rating'] ?? 0).toDouble(),  // Перевірка на null
      currency: (json['currency'] ?? ''),  // Перевірка на null
    );
  }
}
