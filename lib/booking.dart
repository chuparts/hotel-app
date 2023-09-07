import 'package:email_validator/email_validator.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:hotel_app_test_exercise/getting_booking_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'other_tourists_form.dart';

Future<BookInfo> fetchBookInfo() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8'));

  if (response.statusCode == 200) {
    return BookInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load hotel info');
  }
}

class FormChange extends ChangeNotifier {
  void update() {
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }
}

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  late final Future<BookInfo> booking;

  var formKey = GlobalKey<FormState>();
  var phoneKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  // TextEditingController phoneController = TextEditingController();

  String numberController = "";

  List<Color> textFieldColors = [
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9),
    const Color(0xFFF6F6F9)
  ];
  List<String> touristsNumNames = ["Второй", "Третий", "Четвертый", "Пятый"];
  int touristsNum = 1;
  @override
  void initState() {
    super.initState();
    booking = fetchBookInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormChange(),
      child: FutureBuilder(
        future: booking,
        builder: (context, snapshot) {
          var formChange = context.watch<FormChange>();
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          int totalPayment = snapshot.data!.service_charge +
              snapshot.data!.tour_price +
              snapshot.data!.fuel_charge;
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
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: textFieldColors[0],
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                        key: phoneKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              prefix: Text(
                                "+7 ",
                                style: TextStyle(color: Colors.black),
                              ),
                              border: InputBorder.none,
                              hintText: "(***) ***-**-**",
                              labelText: "Номер телефона",
                              labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                          validator: (value) {
                            if (value != null && value.length < 14) {
                              textFieldColors[0] = const Color(0x26EB5757);
                              // formChange.update();
                              return "Номер телефона введен некорректно";
                            } else {
                              textFieldColors[0] = const Color(0xFFF6F6F9);
                              // formChange.update();
                              return null;
                            }
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: "(###) ###-##-##",
                              filter: {"#": RegExp('[0-9]')},
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: textFieldColors[1],
                            borderRadius: BorderRadius.circular(10)),
                        child: Form(
                          key: emailKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Почта",
                                labelStyle:
                                    TextStyle(color: Color(0xFFA9ABB7))),
                            validator: (value) {
                              if (value != null &&
                                  !EmailValidator.validate(value)) {
                                textFieldColors[1] = const Color(0x26EB5757);
                                // formChange.update();
                                return "Почта введена некорректно";
                              } else {
                                textFieldColors[1] = const Color(0xFFF6F6F9);
                                return null;
                              }
                            },
                          ),
                        )),
                    const Text(
                      "Эти данные никому не передаются. После оплаты мы отправим чек на указанный вами номер и почту.",
                      style: TextStyle(fontSize: 14, color: Color(0xFF828796)),
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: const Text(
                        "Первый турист",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      children: [
                        Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[2],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Имя",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[2] =
                                              const Color(0x26EB5757);
                                          return "Введите имя";
                                        } else {
                                          textFieldColors[2] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[3],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Фамилия",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[3] =
                                              const Color(0x26EB5757);
                                          return "Введите фамилию";
                                        } else {
                                          textFieldColors[3] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[4],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Дата рождения",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                          mask: "##.##.##",
                                          filter: {"#": RegExp(r'[0-9]')},
                                        )
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[4] =
                                              const Color(0x26EB5757);
                                          return "Введите дату рождения";
                                        } else {
                                          textFieldColors[4] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[5],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Гражданство",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[5] =
                                              const Color(0x26EB5757);
                                          return "Введите гражданство";
                                        } else {
                                          textFieldColors[5] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[6],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Номер загранпаспорта",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                          mask: "#############",
                                          filter: {"#": RegExp(r'[0-9]')},
                                        )
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[6] =
                                              const Color(0x26EB5757);
                                          return "Введите номер загранпаспорта";
                                        } else {
                                          textFieldColors[6] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        color: textFieldColors[7],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText:
                                              "Срок действия загранпаспорта",
                                          labelStyle: TextStyle(
                                              color: Color(0xFFA9ABB7))),
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                          mask: "##.##.##",
                                          filter: {"#": RegExp(r'[0-9]')},
                                        )
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          textFieldColors[7] =
                                              const Color(0x26EB5757);
                                          return "Введите срок действия загранпаспорта";
                                        } else {
                                          textFieldColors[7] =
                                              const Color(0xFFF6F6F9);
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            )),
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: touristsNum,
                        itemBuilder: (context, itemIndex) {
                          return ExpansionTile(
                            title: Text(
                              "${touristsNumNames[itemIndex]} турист",
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black),
                            ),
                            children: const [OtherTouristsForm()],
                          );
                        })
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (touristsNum < 4) {
                      setState(() {
                        touristsNum++;
                      });
                    }
                  },
                  child: const ListTile(
                    title: Text(
                      "Добавить туриста",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    trailing: Image(image: AssetImage("assets/icons/plus.png")),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "Тур",
                    style: TextStyle(fontSize: 16, color: Color(0xFF828796)),
                  ),
                  trailing: Text(
                    "${snapshot.data!.tour_price.toString()} ₽",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "Топливный сбор",
                    style: TextStyle(fontSize: 16, color: Color(0xFF828796)),
                  ),
                  trailing: Text(
                    "${snapshot.data!.fuel_charge.toString()} ₽",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "Сервисный сбор",
                    style: TextStyle(fontSize: 16, color: Color(0xFF828796)),
                  ),
                  trailing: Text(
                    "${snapshot.data!.service_charge.toString()} ₽",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "К оплате",
                    style: TextStyle(fontSize: 16, color: Color(0xFF828796)),
                  ),
                  trailing: Text(
                    "$totalPayment ₽",
                    textAlign: TextAlign.end,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF0D72FF)),
                  ),
                ),
                Center(
                  child: CupertinoButton.filled(
                      padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
                      borderRadius: BorderRadius.circular(15),
                      onPressed: () {
                        setState(() {
                          if (!formKey.currentState!.validate() ||
                              !emailKey.currentState!.validate() ||
                              !phoneKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Заполните все поля"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Ок"))
                                      ],
                                    ));
                          }
                          else
                          {
                            
                          }
                        });
                      },
                      child: Text("Оплатить $totalPayment ₽")),
                ),
              ]),
            ]),
          );
        },
      ),
    );
  }
}
