import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../screens/UserLinking.dart';
import '../screens/User.dart';
import 'editprofilenew.dart';
import '/User/dasboard/screens/components/side_menu.dart';
import '/User/Authentification/profile/editprofilenew.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserController contactController;
  late List<User> users;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    // Get the last user
    User? lastUser = users.isNotEmpty ? users.last : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        actions: [
          SizedBox(
            height: 40,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Transform.scale(
                scale: 1.2,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/profile.jpg"),
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
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.1,
                            ),
                            SizedBox(
                              height: size.height * 0.3,
                              width: size.width * 0.5,
                              child: Image.asset(
                                "images/profilinfo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "Check Your personal infos",
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xFF102D4D),
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                              height: size.height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextField(
                                    style: GoogleFonts.nunitoSans(),
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      prefixIcon: const Icon(Icons.person),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                      hintText: '${lastUser?.name ?? ""}',
                                      hintStyle: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      ),
                                      fillColor: Colors.black12,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    style: GoogleFonts.nunitoSans(),
                                    readOnly: true,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      prefixIcon: const Icon(Icons.phone),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                      hintText: '${lastUser?.phone ?? ""}',
                                      hintStyle: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      ),
                                      fillColor: Colors.black12,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Edit(), // Correction: EditProfileNew instead of Edit
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.11,
                                        vertical: size.height * 0.015,
                                      ),
                                      backgroundColor: const Color(0xFF102D4D),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      "Edit Account",
                                      style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
