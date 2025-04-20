class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final num rating;
  final String category;
  final String thumbnail;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}

class ProductResponse {
  final List<Product> products;

  ProductResponse({required this.products});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products:
          List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
    );
  }
}
