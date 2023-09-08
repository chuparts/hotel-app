import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hotel_app_test_exercise/getting_hotel_info.dart';
import 'package:hotel_app_test_exercise/rooms.dart';

late String hotelName;
double heightSpace1 = 8;
double heightSpace2 = 12;

Future<HotelInfo> fetchHotelInfo() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3'));

  if (response.statusCode == 200) {
    return HotelInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load hotel info');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/main': (context) => const HotelMainScreen(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF6F6F9),
          fontFamily: 'SFProDisplay',
        ),
        debugShowCheckedModeBanner: false,
        home: const HotelMainScreen());
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: const Text(
            "Отель",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: hotelInfo,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              hotelName = snapshot.data!.name;
              return ListView(children: [
                Column(
                  // column for the whole page
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // container of the first block
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Padding(
                        // this padding must be in all of the blocks
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          // column fo the first block
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: heightSpace1,
                            ),
                            Stack(children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      height: 257,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                            SizedBox(
                              height: heightSpace2,
                            ),
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
                            SizedBox(
                              height: heightSpace1,
                            ),
                            Text(
                              snapshot.data!.name,
                              style: const TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              height: heightSpace1,
                            ),
                            Text(
                              snapshot.data!.adress,
                              style: const TextStyle(color: Color(0xFF0D72FF)),
                            ),
                            SizedBox(
                              height: heightSpace2,
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
                      ),
                    ),
                    SizedBox(
                      height: heightSpace1,
                    ),
                    Container(
                      // container of the second block
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Об отеле",
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              height: heightSpace2,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot
                                    .data!.about["peculiarities"].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFFBFBFC),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            snapshot.data!
                                                .about["peculiarities"][index]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xFF828796)),
                                          )),
                                    ],
                                  );
                                }),
                            SizedBox(
                              height: heightSpace1,
                            ),
                            Text(
                              snapshot.data!.about['description'],
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: heightSpace2,
                            ),
                            Column(
                              children: [
                                const ListTile(
                                  leading: Image(
                                      image: AssetImage(
                                          "assets/icons/emoji-happy.png")),
                                  title: Text("Удобства"),
                                  subtitle: Text("Самое необходимое"),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                const ListTile(
                                  leading: Image(
                                      image: AssetImage(
                                          "assets/icons/tick-square.png")),
                                  title: Text("Что включено"),
                                  subtitle: Text("Самое необходимое"),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                const ListTile(
                                  leading: Image(
                                      image: AssetImage(
                                          "assets/icons/close-square.png")),
                                  title: Text("Что не включено"),
                                  subtitle: Text("Самое необходимое"),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                ),
                                CupertinoButton.filled(
                                    padding:
                                        const EdgeInsets.fromLTRB(115, 0, 115, 0),
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RoomsPage()));
                                    },
                                    child: const Text("К выбору номера")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]);
            }));
  }
}
