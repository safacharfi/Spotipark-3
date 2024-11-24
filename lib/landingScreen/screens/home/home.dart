import 'package:flutter/material.dart';
import '/landingScreen/components/header.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/jumbotron.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/User/BoardingScreen/page/onboarding_page.dart';

class BoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Drawer(
          // Drawer content
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                width: size.width,
                constraints: BoxConstraints(minHeight: size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Header(),
                    Jumbotron(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Admin or User? Your choice defines your SpotiPark journey. Click on the suitable icon and let the adventure begin!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.courgette(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image.asset('assets/user.png'),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigate to register user page
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OnBoardingPage(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0XFF2B224B)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text('User'),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Image.asset('assets/admin.png'),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigate to admin login page
                                      Navigator.of(context).pushNamed(
                                        '/login',
                                        arguments: "owner",
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0XFF2B224B)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text('Admin'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
