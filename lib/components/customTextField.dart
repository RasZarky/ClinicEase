import 'package:flutter/material.dart';

import 'constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final int? maxlines;
  final int? minlines;
  bool isObsecure = true;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.data,
    required this.hintText,
    required this.isObsecure,
    required this.textInputType,
    required this.labelText,
    required this.maxlines,
    required this.minlines,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        keyboardType: textInputType,
        maxLines: maxlines,
        minLines: minlines,
        style: const TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black54
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(
            data,
            color: secondaryColor,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black54
          ),
        ),
      ),
    );
  }
}
