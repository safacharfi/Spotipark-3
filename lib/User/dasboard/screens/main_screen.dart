import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'components/side_menu.dart';
import '../../Authentification/screens/UserLinking.dart';
import '../../Authentification/screens/User.dart';
import 'components/chart_container.dart';
import '../widgets/courses_grid.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late UserController contactController;
  late List<User> users;
  late User? lastUser;

  @override
  void initState() {
    super.initState();
    contactController = Provider.of<UserController>(context, listen: false);
    users = contactController.users;
    lastUser = users.isNotEmpty ? users.last : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend body behind the app bar
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.transparent, // Set app bar background color to transparent
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        actions: [
          SizedBox(
            height: 40, // Adjust the height to add vertical spacing
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Transform.scale(
                scale: 1.2, // Adjust the scale factor to make the image bigger
                child: CircleAvatar(
                  radius:
                      25, // Adjust the radius for the size of the CircleAvatar
                  backgroundImage: AssetImage(
                      "images/profile.jpg"), // Adjust the path and file name accordingly
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "images/back.png"), // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30), // Add vertical spacing here
                RichText(
                  text: TextSpan(
                    text: "Hello ",
                    style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '${lastUser?.name ?? ""} !',
                        style: TextStyle(
                          color: kDarkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ), // Make the text bold
                      ),
                      const TextSpan(
                        text: " welcome back !",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "What are you up to today ?",
                      style: GoogleFonts.courgette(
                        // Use Google Fonts Courgette
                        textStyle: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const CourseGrid(),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
