import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app_test_exercise/booking.dart';
import 'package:hotel_app_test_exercise/getting_rooms_info.dart';
import 'package:hotel_app_test_exercise/hotel_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<RoomInfo>> fetchRoomInfo() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd'));

  if (response.statusCode == 200) {
    List<RoomInfo> rooms = [];
    for (dynamic f in jsonDecode(response.body)['rooms']) {
      rooms.add(RoomInfo.fromJson(f));
    }
    return rooms;
  } else {
    throw Exception('Failed to load rooms info');
  }
}

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});
  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  late final Future<List<RoomInfo>> rooms;
  List<int> dotPosition = [];
  @override
  void initState() {
    super.initState();
    rooms = fetchRoomInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rooms,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          for (int i = 0; i < snapshot.data!.length; i++) {
            dotPosition.add(0);
          }
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                elevation: 1,
                title: Text(
                  hotelName,
                  style: const TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                            snapshot
                                                .data![index].images[itemIndex],
                                            fit: BoxFit.fill,
                                          );
                                        },
                                        itemCount:
                                            snapshot.data![index].images.length,
                                        onPageChanged: (int pos) {
                                          setState(() {
                                            dotPosition[index] = pos;
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
                                        dotsCount:
                                            snapshot.data![index].images.length,
                                        position: dotPosition[index],
                                        decorator: const DotsDecorator(
                                            activeColor: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: heightSpace1,
                            ),
                            Text(
                              snapshot.data![index].name,
                              style: const TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              height: heightSpace1,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    snapshot.data![index].peculiarities.length,
                                itemBuilder:
                                    (BuildContext context, int listIndex) {
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
                                            snapshot.data![index]
                                                .peculiarities[listIndex]
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
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0x330D72FF)),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Подробнее о номере",
                                    style: TextStyle(
                                        color: Color(0xFF0D72FF), fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF0D72FF),
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: heightSpace2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${snapshot.data![index].price.toString()} ₽",
                                    style: const TextStyle(fontSize: 30)),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  snapshot.data![index].pricePer,
                                  style: const TextStyle(
                                      color: Color(0xFF828796), fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: heightSpace2,
                            ),
                            Center(
                              child: CupertinoButton.filled(
                                  padding:
                                      const EdgeInsets.fromLTRB(120, 0, 120, 0),
                                  borderRadius: BorderRadius.circular(15),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Booking()));
                                  },
                                  child: const Text("Выбрать номер")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpace1,
                    )
                  ],
                );
              },
            ),
          );
        });
  }
}
