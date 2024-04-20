import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/authentication_button.dart';
import '../components/custom_text_field.dart';
import '../components/curve.dart';
import '../constants.dart';
import 'signup_screen.dart';
import 'UserLinking.dart';
import 'package:provider/provider.dart';
import '../../Car/screens/home-screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    UserController contactsController = Provider.of<UserController>(context);

    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        fit: StackFit.expand,
        children: [
          // First Child in the stack
          ClipPath(
            clipper: ImageClipper(),
            child: Image.asset(
              '../../../images/cars.png',
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20.0,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kDarkGreenColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
          // Second Child in the stack
          Positioned(
            height: MediaQuery.of(context).size.height * 0.67,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.67,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // First Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome Back',
                            style: GoogleFonts.courgette(),
                          ),
                          Text(
                            'Login to your account',
                            style: GoogleFonts.courgette(
                              fontSize: 24, // Set the desired font size
                            ),
                          )
                        ],
                      ),
                      // Second Column
                      Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              icon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              icon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {},
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  fillColor: MaterialStateProperty.all(
                                      kDarkGreenColor),
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Third Column
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AuthenticationButton(
                              label: 'Log In',
                              onPressed: () async {
                                String name = _nameController.text.trim();
                                String password =
                                    _passwordController.text.trim();

                                if (name.isNotEmpty && password.isNotEmpty) {
                                  bool isAuthenticated =
                                      await contactsController.signIn(
                                          name, password);
                                  if (isAuthenticated) {
                                    // Navigate to the home page
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  } else {
                                    // Show an alert in case of login failure
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Login Failed"),
                                          content: Text(
                                              "Invalid username or password. Please try again."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account ?',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              kDarkGreenColor),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
