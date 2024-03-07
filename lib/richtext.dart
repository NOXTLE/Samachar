import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class rich_text extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
            child: RotatedBox(
      quarterTurns: 8,
      child: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png"),
    )));
  }
}
