import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'home_page.dart';
import '../widget/button_widget.dart';
import '../../dasboard/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import '../../Authentification/screens/login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'images/back.png'), // Set your background image here
          fit: BoxFit.cover,
        ),
      ),
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to SpotiPark's smart Parking App",
            body: 'Find and book parking spots with ease.',
            image: buildImage('assets/1.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Effortless Parking Experience',
            body:
            'Say goodbye to the hassle of searching for parking. Our app allows you to find and book parking spots conveniently.',
            image: buildImage('assets/3.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Secure and Reliable',
            body:
            'Rest assured knowing that your vehicle is parked in safe and monitored parking spaces.',
            image: buildImage('assets/7.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Save Time and Money',
            body:
            'Avoid wasting time and money on parking fees. Our app helps you find affordable parking options near your destination.',
            image: buildImage('assets/4.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Get Started!',
            body: 'Sign up or log in to start your journey with Spotipark',
            footer: SizedBox(
              width: 20, // Specify the desired width for the button
              child: ButtonWidget(
                text: 'Get started',
                onClicked: () => goToMainScreen(context),
              ),
            ),
            image: buildImage('assets/6.png'),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text(
          'Get Started',
          style: TextStyle(
            fontSize: 18, // Adjust the font size as needed
            color: Colors.black,
          ),
        ),
        onDone: () => LoginScreen(), // Update this line
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        onSkip: () => goToLoginScreen(context), // Update this line
        next: Icon(
          Icons.arrow_forward,
          color: Colors.black, // Change arrow icon color to black
        ),
        dotsDecorator: DotsDecorator(
          color: Color.fromARGB(255, 1, 0, 0), // Set dot color to red
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          activeColor: Color(0xFF333A73), // Set active dot color to #F6CB22
        ),
        onChange: (index) {
          setState(() {
            _currentPageIndex = index;
          });
          print('Page $index selected');
        },
        globalBackgroundColor:
        Colors.transparent, // Make the background transparent
        nextFlex: 0,
      ),
    ),
  );

  void goToLoginScreen(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginScreen()),
  );

  void goToMainScreen(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginScreen()),
  );

  Widget buildImage(String path, {double? width, double? height}) =>
      Image.asset(
        path,
        width: width,
        height: height,
      ); // Use the original image widget

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: GoogleFonts.courgette(
      // Use Google Fonts "Courgette" for titles
      textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    bodyTextStyle: TextStyle(fontSize: 20),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.transparent, // Make the page background transparent
  );
}
