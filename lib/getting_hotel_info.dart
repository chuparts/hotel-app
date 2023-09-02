import 'dart:convert';
import 'package:http/http.dart' as http;

class HotelInfo {
  final int id;
  final String name;
  final String adress;
  final int price;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<dynamic> images;
  final Map<String, dynamic> about;

  HotelInfo(
      {required this.adress,
      required this.id,
      required this.name,
      required this.price,
      required this.priceForIt,
      required this.rating,
      required this.ratingName,
      required this.images,
      required this.about});

  factory HotelInfo.fromJson(Map<String, dynamic> json) {
    return HotelInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      adress: json['adress'] as String,
      price: json['minimal_price'] as int,
      priceForIt: json['price_for_it'] as String,
      rating: json['rating'] as int,
      ratingName: json['rating_name'] as String,
      images: json['image_urls'],
      about: json['about_the_hotel'],
    );
  }

  Future<http.Response> fetchHotelInfo() {
    return http.get(Uri.parse(
        'https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));
  }

  // int getId() {
  //   return id;
  // }

  // Future<List<String>> getImages() {
  //   return images;
  // }
}
