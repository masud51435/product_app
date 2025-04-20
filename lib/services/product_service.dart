import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductService {
  static const baseUrl = 'https://dummyjson.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl?limit=100'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).products;
    } else {
      throw Exception('Search failed');
    }
  }

static Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('$baseUrl/categories'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}


  static Future<List<Product>> fetchByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/category/$category'));
    if (response.statusCode == 200) {
      return ProductResponse.fromJson(json.decode(response.body)).products;
    } else {
      throw Exception('Failed to filter by category');
    }
  }
}
