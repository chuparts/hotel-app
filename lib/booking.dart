import 'package:hotel_app_test_exercise/getting_booking_info.dart';
import 'package:hotel_app_test_exercise/getting_rooms_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<BookInfo> fetchBookInfo() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8'));

  if (response.statusCode == 200) {
    return BookInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load hotel info');
  }
}

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late final Future<BookInfo> booking;
  @override
  void initState() {
    super.initState();
    booking = fetchBookInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: booking,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
              elevation: 1,
              title: const Text(
                "Бронирование",
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
          body: ListView(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      "${snapshot.data!.horating} ${snapshot.data!.ratingName}",
                      style: const TextStyle(
                          color: Color(0xFFFFA800), fontSize: 16),
                    ),
                  ],
                ),
              ),
              Text(
                snapshot.data!.hotel_name,
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                snapshot.data!.hotel_adress,
                style: const TextStyle(color: Color(0xFF0D72FF)),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Вылет из",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.departure,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Страна, город",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.arrival_country,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Даты",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            "${snapshot.data!.date_start} - ${snapshot.data!.date_stop}",
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Кол-во ночей",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.num_nights.toString(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Отель",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.hotel_name,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Номер",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.room,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: ListTile(
                          leading: Text(
                            "Питание",
                            style: TextStyle(
                                color: Color(0xFF828796), fontSize: 16),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            snapshot.data!.nutrition,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Text(
                "Информация о покупателе",
                style: TextStyle(fontSize: 22),
              ),
              
            ]),
          ]),
        );
      },
    );
  }
}
