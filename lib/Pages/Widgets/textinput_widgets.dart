import 'package:flutter/material.dart';

TextFormField registrationTextFields(TextEditingController controller,IconData icon,String hint,String label) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon,size: 25,),
      fillColor: Colors.white70,
      filled: true,
      hintText: hint,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
  );
}