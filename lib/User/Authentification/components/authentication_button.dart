import 'package:flutter/material.dart';
import '/User/Authentification/constants.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12.0),
        ),
        backgroundColor: MaterialStateProperty.all(kDarkGreenColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
      ),
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}
