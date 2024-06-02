import 'package:flutter/material.dart';
Row textWidgets(String value) {
  return Row(

    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      profileTxt(value),
    ],
  );
}

Text profileTxt(String value) {
  return Text(value,style: TextStyle(
    fontSize: 15,
    color: Color(0xFF959FA8),
    fontFamily: "Poppins-semiBold",
  ),);
}