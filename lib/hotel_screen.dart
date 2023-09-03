import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app_test_exercise/getting_hotel_info.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  int dotPosition = 0;

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
                return ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Stack(children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                height: 257,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(15)),
                                child: PageView.builder(
                                  itemBuilder:
                                      (BuildContext context, itemIndex) {
                                    return Image.network(
                                      snapshot.data!.images[itemIndex],
                                      fit: BoxFit.fill,
                                    );
                                  },
                                  itemCount: snapshot.data!.images.length,
                                  onPageChanged: (int pos) {
                                    setState(() {
                                      dotPosition = pos;
                                    });
                                  },
                                )),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 220,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: DotsIndicator(
                                  dotsCount: snapshot.data!.images.length,
                                  position: dotPosition,
                                  decorator: const DotsDecorator(
                                      activeColor: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0x33FFC700)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFA800),
                              size: 15,
                            ),
                            Text(
                              "${snapshot.data!.rating} ${snapshot.data!.ratingName}",
                              style: const TextStyle(
                                  color: Color(0xFFFFA800), fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        snapshot.data!.name,
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        snapshot.data!.adress,
                        style: const TextStyle(color: Color(0xFF0D72FF)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("От ${snapshot.data!.price.toString()} ₽",
                              style: const TextStyle(fontSize: 30)),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            snapshot.data!.priceForIt,
                            style: const TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ]);
              })),
    );
  }
}





// padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: const Color(0x33FFC700)),★