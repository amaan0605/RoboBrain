import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';

/*------HomePageCard------*/

Widget homePageCard({required String imagePath}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      children: [
        SizedBox(
          height: 300,
          width: 400,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 300,
          width: 400,
          color: Colors.black54,
        ),
      ],
    ),
  );
}

Flexible textFormField(TextEditingController chatController) {
  return Flexible(
    child: TextFormField(
      style: const TextStyle(color: botBackgroundColor),
      controller: chatController,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: botBackgroundColor.withOpacity(0.5)),
          hintText: 'How may i help you!',
          border: InputBorder.none),
    ),
  );
}
