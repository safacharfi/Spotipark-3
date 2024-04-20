import 'package:flutter/material.dart';
import '/User/Authentification/components/bottom_nav_bar.dart';
import '/User/Authentification/constants.dart';
import '/User/Authentification/screens/cart_screen.dart';
import '/User/Authentification/screens/home_screen.dart';
import '/User/balance/presentation/pages/home_page.dart';
import '../profile/profile.dart'; // Importez la page de profil

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String id = 'MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  // Définissez les routes correspondantes à chaque icône
  List<Widget> screens = [
    HomeScreen(),
    BalancePage(), // Utilisez directement la classe BalancePage
    CartScreen(),
    MyHomePage(title:'my profile'), // Utilisez directement la classe ProfilePage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        selectedColor: kDarkGreenColor,
        unselectedColor: kSpiritedGreen,
        onTapped: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.home),
          Icon(Icons.image_search_outlined),
          Icon(Icons.receipt),
          Icon(Icons.person),
        ],
      ),
      body: _buildBody(selectedIndex),
    );
  }

  // Fonction pour construire le corps en fonction de l'index sélectionné
  Widget _buildBody(int index) {
    return screens[index];
  }
}
