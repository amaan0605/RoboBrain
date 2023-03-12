import 'package:flutter/material.dart';

import 'constants.dart';

class DalleTextFormField extends StatelessWidget {
  const DalleTextFormField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
            color: botBackgroundColor, borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          controller: searchController,
          decoration: const InputDecoration(
              hintText: 'Type something Magical...', border: InputBorder.none),
        ),
      ),
    );
  }
}
