class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final Rating rating; 

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.rating, 
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? "Unknown Product",
      description: json['description'] ?? "No description available",
      image: json['image'] ?? 'https://via.placeholder.com/150',
      price: (json['price'] as num).toDouble(),
      rating: Rating.fromJson(json['rating'] ?? {}),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }
}