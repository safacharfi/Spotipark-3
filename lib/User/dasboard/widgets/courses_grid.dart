import 'package:flutter/material.dart';
import 'package:land_registration/User/booking/screens/search_screen.dart';
import '/User/balance/presentation/pages/home_page.dart';
import '../data/data.dart'; // Assurez-vous d'importer correctement vos données de cours depuis le fichier data.dart
import '../../Authentification/profile/newprofilepage.dart';
import '../../Car/listVehicule.dart';
import '/User/booking/screens/home_screen.dart';
import '/User/booking/screens/profile_screeen.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: course.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _navigateToPage(context, index);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(course[index].backImage), fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        course[index].text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20, // Increase the fontSize value
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        course[index].imageUrl,
                        height: 110,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BalancePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehiculePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
        break;
          case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AmountScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      default:
        // Gérer les autres cas si nécessaire
        break;
    }
  }
}
