import 'package:flutter/material.dart';
import '/landingScreen/components/main_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class Jumbotron extends StatelessWidget {
  const Jumbotron({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          bottom: 20, left: 40, right: 40, top: 0), // Adjusted vertical margin
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome To\n',
                          style: GoogleFonts.courgette(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: kTextColor,
                          ),
                        ),
                        TextSpan(
                          text: 'SpotiPark',
                          style: GoogleFonts.courgette(
                            fontSize: 64,
                            fontWeight: FontWeight.w800,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Your Smart Parking App',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.courgette(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Experience hassle-free parking with our innovative Smart Parking App, revolutionizing convenience through Ethereum blockchain technology.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      MainButton(
                        title: 'Learn More',
                        color: kPrimaryColor,
                        tapEvent: () {},
                      ),
                      SizedBox(width: 10),
                      MainButton(
                        title: 'Watch Demo',
                        color: kSecondaryColor,
                        tapEvent: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/mainn.png',
            ),
          ),
        ],
      ),
    );
  }
}
