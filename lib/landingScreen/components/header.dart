import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 0, bottom: 20, left: 20, right: 20), // Adjusted top margin

      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            width: 350,
            height: 150,
          ),
        ],
      ),
    );
  }
}
