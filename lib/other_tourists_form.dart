

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OtherTouristsForm extends StatelessWidget {
  const OtherTouristsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Имя",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                )),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Фамилия",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                )),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Дата рождения",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: "##.##.##",
                      filter: {"#": RegExp(r'[0-9]')},
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Гражданство",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                )),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Номер загранпаспорта",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: "#############",
                      filter: {"#": RegExp(r'[0-9]')},
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Срок действия загранпаспорта",
                      labelStyle: TextStyle(color: Color(0xFFA9ABB7))),
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: "##.##.##",
                      filter: {"#": RegExp(r'[0-9]')},
                    )
                  ],
                )),
          ],
        ));
  }
}