import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';  // імпортуйте вашу модель Product

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://run.mocky.io/v3/7f431cd0-2769-492d-b949-294ca192caf1'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
