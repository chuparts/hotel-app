import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app_test_exercise/getting_rooms_info.dart';
import 'package:hotel_app_test_exercise/hotel_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<RoomInfo>> fetchRoomInfo() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd'));

  if (response.statusCode == 200) {
    List<RoomInfo> rooms = [];
    for (dynamic f in jsonDecode(response.body)['rooms'])
    {
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
  int dotPosition = 0;
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
          if (!snapshot.hasData)
          {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
                elevation: 1,
                title: Text(
                  hotelName,
                  style: TextStyle(color: Colors.black),
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
            body: ListView.builder(itemBuilder: (context, index) {
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
                                itemBuilder: (BuildContext context, itemIndex) {
                                  return Image.network(
                                    snapshot.data![index].images[itemIndex],
                                    fit: BoxFit.fill,
                                  );
                                },
                                itemCount: snapshot.data![index].images.length,
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
                                dotsCount: snapshot.data![index].images.length,
                                position: dotPosition,
                                decorator: const DotsDecorator(
                                    activeColor: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
            },),
          );
        });
  }
}
