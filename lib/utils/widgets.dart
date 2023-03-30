import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';

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
