import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../widget/color_changing_container.dart';
import '../add.dart';
import '../../dasboard/screens/main_screen.dart';
import '/User/Car/VehiculeLinking.dart';
import '../../Authentification/screens/UserLinking.dart';
import '../../Authentification/screens/User.dart';

enum Type {
  car,
  bike,
  van,
}

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Type? selectedType;
  String _carImage = 'images/car (1).png';
  late UserController contactController;
  late List<User> users;
  late Size size;

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<VehicleController>(context);
    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SpotiPark.',
                      style: GoogleFonts.courgette(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to profile page when Skip button is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: Container(
                        height: 32, // Adjust height as needed
                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF428bc4), // Same color as "Tap to add" button
                          borderRadius: BorderRadius.circular(
                              16), // Adjust borderRadius as needed
                        ),
                        child: Center(
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Make the font smaller
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 27, top: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${users.isNotEmpty ? "We are glad to see you again, ${users[users.length - 1].name}!" : ""}',
                    style: GoogleFonts.bubblegumSans(
                      textStyle: TextStyle(
                        color:
                            Color(0xFF428bc4), // Change text color to #428bc4
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = Type.car;
                            _carImage = 'images/car (1).png';
                          });
                        },
                        child: ColorChangingContainer(
                          containerColor: selectedType == Type.car
                              ? inActiveContainerColor
                              : activeContainerColor,
                          containerIcon: Icon(
                            FontAwesomeIcons.car,
                            size: 30,
                            color: selectedType == Type.car
                                ? inActiveTextColor
                                : activeTextColor,
                          ),
                          containerText: 'Car',
                          myTextColor: selectedType == Type.car
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = Type.bike;
                            _carImage = 'images/bike (2).png';
                          });
                        },
                        child: ColorChangingContainer(
                          containerColor: selectedType == Type.bike
                              ? inActiveContainerColor
                              : activeContainerColor,
                          containerIcon: Icon(
                            FontAwesomeIcons.motorcycle,
                            size: 30,
                            color: selectedType == Type.car
                                ? inActiveTextColor
                                : activeTextColor,
                          ),
                          containerText: 'Bike',
                          myTextColor: selectedType == Type.bike
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = Type.van;
                            _carImage = 'images/bus.png';
                          });
                        },
                        child: ColorChangingContainer(
                          containerColor: selectedType == Type.van
                              ? inActiveContainerColor
                              : activeContainerColor,
                          containerIcon: Icon(
                            FontAwesomeIcons.bus,
                            size: 30,
                            color: selectedType == Type.van
                                ? inActiveTextColor
                                : activeTextColor,
                          ),
                          containerText: 'van',
                          myTextColor: selectedType == Type.van
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          children: [
                            Image.asset('images/line1.png'),
                            const SizedBox(width: 80),
                            Image.asset(
                              _carImage,
                              height: 330.h,
                            ),
                            const SizedBox(width: 75),
                            Image.asset('images/line2.png')
                          ],
                        ),
                        Positioned(
                          left: 127,
                          top: 280,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddVehicule()),
                                );
                              },
                              child: Container(
                                height: 80.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Color(
                                      0xFF428bc4), // Same color as "Tap to add" button
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Tap to add',
                                    style: TextStyle(
                                      fontFamily: 'Anta-Regular.ttf',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to close the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    return exitApp;
  }
}
