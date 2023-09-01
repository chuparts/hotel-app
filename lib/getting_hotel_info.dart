import 'dart:convert';
import 'package:http/http.dart' as http;

class HotelInfo {
  final int id;
  final String name;
  // final String adress;
  // final int price;
  // final String priceForIt;
  // final int rating;
  // final String ratingName;
  // final List<dynamic> images;
  // final List<dynamic> about;

  HotelInfo(
      {
      required this.id,
      required this.name});

  factory HotelInfo.fromJson(Map<String, dynamic> json) {
    return HotelInfo(
      id: json['id'],
      name: json['name'],
      // adress: json['adress'],
      // price: json['minimal_price'],
      // priceForIt: json['price_for_it'],
      // rating: json['rating'],
      // ratingName: json['rating_name'],
      // images: json['image_urls'],
    );
  }

  Future<http.Response> fetchHotelInfo() {
  return http.get(Uri.parse('https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));
}

  // int getId() {
  //   return id;
  // }

  // Future<List<String>> getImages() {
  //   return images;
  // }
}
