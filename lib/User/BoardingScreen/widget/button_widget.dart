import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final double width;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.width = double.infinity, // Set default width to match parent width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        child: ElevatedButton(
          onPressed: onClicked,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.black, // Set button background color to black
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(20, 50), // Adjust button size as needed
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
