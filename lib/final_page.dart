import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app_test_exercise/hotel_screen.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: const Text(
            "Заказ оплачен",
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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image(image: AssetImage("assets/icons/final_icon.png")),
              SizedBox(
                height: 32,
              ),
              Text(
                "Ваш заказ принят в работу",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF828796)),
              )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CupertinoButton.filled(
            padding: const EdgeInsets.fromLTRB(125, 0, 125, 0),
            borderRadius: BorderRadius.circular(15),
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            child: const Text("Супер!")),
      ),
    );
  }
}
