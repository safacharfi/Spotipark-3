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
import '/license_plate_detector.dart';

enum Type {
  car,
  bike,
  van,
}

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Type? selectedType;
  String _carImage = 'images/car (1).png';
  late UserController contactController;
  late List<User> users;

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<VehicleController>(context);
    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
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
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF428bc4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
                    users.isNotEmpty
                        ? "We are glad to see you again, ${users[users.length - 1].name}!"
                        : "",
                    style: GoogleFonts.bubblegumSans(
                      textStyle: const TextStyle(
                        color: Color(0xFF428bc4),
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
                            color: selectedType == Type.bike
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
                          containerText: 'Van',
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
                            Image.asset('images/line2.png'),
                          ],
                        ),
                        Positioned(
                          left: 127,
                          top: 280,
                          child: Column(
                            children: [
                              TextButton(
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
                                    color: const Color(0xFF428bc4),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Tap to add',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LicensePlateDetector(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 80.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Add via Plate',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
