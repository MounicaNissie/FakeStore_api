import 'dart:convert';
import 'package:http/http.dart' as http;

class Product{
  final int id;
  final String title;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image
  });

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'].toDouble(),
        image: json['image'],
    );
  }


}

Future<List<Product>> fetchProducts() async{
  const url = 'https://fakestoreapi.com/products/';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((product) => Product.fromJson(product)).toList();
  }
  else{
    throw Exception('failed to load products');
  }
}