import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../screens/UserLinking.dart';
import '../screens/User.dart';
import 'newprofilepage.dart';
import '/User/Authentification/profile/editprofilenew.dart';
import '/User/dasboard/screens/components/side_menu.dart';

class Edit extends StatefulWidget {
  final User? user;

  const Edit({Key? key, this.user}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _passwordController =
        TextEditingController(text: widget.user?.password ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final contactController =
        Provider.of<UserController>(context, listen: true);
    final users = contactController.users;
    final size = mediaQuery.size;
    final lastUser = users.isNotEmpty ? users.last : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
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
          height: size.height, // Set container height to match screen height
          width: size.width, // Set container width to match screen width
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
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 0.5,
                    child: Image.asset(
                      "images/profiledit.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Edit Your Personal Information ',
                  style: GoogleFonts.nunitoSans(
                    color: Color(0xFF102D4D),
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                    child: Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Name',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: _nameController,
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
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
                        Text(
                          'Password',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            hintText: '${lastUser?.password ?? ""}',
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
                        Text(
                          'Phone Number',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: _phoneController,
                          style: GoogleFonts.nunitoSans(),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
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
                        SizedBox(height: size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            await handleSaveNote();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: size.width * .11,
                                vertical: size.height * .015,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xFF102D4D),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * .04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSaveNote() async {
    final contactController =
        Provider.of<UserController>(context, listen: false);

    if (widget.user == null) {
      await contactController.addUser(
        User(
          '0',
          name: _nameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
        ),
      );
    } else {
      await contactController.editUser(
        User(
          widget.user!.id,
          name: _nameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
        ),
      );
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => ProfileScreen()),
      (route) => false,
    );
  }
}
