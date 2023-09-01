import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//import 'package:hotel_app_test_exercise/getting_hotel_info.dart';
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

//   Future<http.Response> fetchHotelInfo() {
//   return http.get(Uri.parse('https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));
// }

  // int getId() {
  //   return id;
  // }

  // Future<List<String>> getImages() {
  //   return images;
  // }
}


Future<HotelInfo> fetchHotelInfo() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));

    if (response.statusCode == 200) {
      return HotelInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load hotel info');
    }
  }

class HotelMainScreen extends StatefulWidget {
  const HotelMainScreen({super.key});

  @override
  State<HotelMainScreen> createState() => _HotelMainScreenState();
}

class _HotelMainScreenState extends State<HotelMainScreen> {
  late final Future<HotelInfo> hotelInfo;

  @override
  void initState() {
    super.initState();
    hotelInfo = fetchHotelInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SFProDisplay'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: const Center(
                child: Text(
              "Отель",
              style: TextStyle(color: Colors.black),
            )),
            backgroundColor: Colors.white,
          ),
          body: FutureBuilder(
              future: hotelInfo,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                  return Text(snapshot.data!.name);//ListView(
                  //   children: [
                  //     CarouselSlider.builder(
                  //       itemCount: snapshot.data!.images.length,
                  //       itemBuilder:
                  //           (BuildContext context, itemIndex, pageViewIndex) {
                  //         return Image.network(
                  //             snapshot.data!.images[itemIndex]);
                  //       },
                  //       options: CarouselOptions(
                  //         autoPlay: false,
                  //         enlargeCenterPage: true,
                  //         viewportFraction: 0.9,
                  //         aspectRatio: 2.0,
                  //         initialPage: 1,
                  //       ),
                  //     )
                  //   ],
                  // );
              })),
    );
  }
}
