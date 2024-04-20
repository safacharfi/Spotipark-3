import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:land_registration/Admin/screens/addLandInspector.dart';
import 'package:provider/provider.dart';
import 'parkinglotLinking.dart';
import 'parkinglotdetail.dart';
import 'parkinglotEdit.dart';
import 'parkinglotEdit.dart';
import 'Parking.dart';
import '../constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/Admin/providers/LandRegisterModel.dart';
import 'package:land_registration/Admin/widget/menu_item_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../constant/utils.dart';
import '../providers/MetamaskProvider.dart';
import '../Money/timeslot_home_screen.dart';
import 'home_screen.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  late ParkingController parkingController;
  late List<Parking> parkings;
    int screen = 0;

  List<Menu> menuItems = [
    Menu(title: 'Add Admin', icon: Icons.person_add),
    Menu(title: 'All Admins', icon: Icons.group),
    Menu(title: 'Change Contract Owner', icon: Icons.change_circle),
    Menu(title: 'Parking Management', icon: Icons.local_parking),
    Menu(title: 'Tariff Management', icon: Icons.monetization_on),
    Menu(title: 'Logout', icon: Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    parkingController = Provider.of<ParkingController>(context, listen: true);
    parkings = parkingController.parkings;
    debugPrint("number of parking lots ${parkings.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFEEC705),
        title: const Text(
          'Add your Parking',
        ),
      ),
      drawer: drawer2(),
      drawerScrimColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: parkingController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your Parking lots",
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: parkings.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  const Divider(
                                    height: 15,
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          '#',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text('Name',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        flex: 3,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text('Location',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text('Capacity',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        flex: 2,
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 15,
                                  )
                                ],
                              );
                            }
                            final parking = parkings[index - 1];
                            return ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('${index.toString()}'),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text('${parking.name}'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text('${parking.location}'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text('${parking.capacity}'),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ParkingDetailScreen(
                                      parking: parking,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

 Widget drawer2() {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)
        ],
        color: Color(0xFF272D34),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
          const SizedBox(
            width: 30,
          ),
          const Text('Contract Owner',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, counter) {
                return const Divider(
                  height: 2,
                );
              },
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    menuItems[index].icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    menuItems[index].title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // Gérer la navigation en fonction de l'élément de menu sélectionné
                    // Ici, je vous montre comment naviguer vers différentes pages en fonction de l'index de l'élément de menu
                    if (index == 0) {
                      // Si l'élément de menu sélectionné est "Add Admin"
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>AddLandInspector()));
                    } else if (index == 3) {
                      // Par exemple, si l'élément de menu sélectionné est "Parking Management"
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ParkingScreen()));
                    } else if (index == 4) {
                      // Si l'élément de menu sélectionné est "Tariff Management"
                      // Vous pouvez ajouter d'autres cas ici pour les autres éléments de menu
                    }
                    // Vous pouvez ajouter d'autres cas ici pour gérer la navigation pour d'autres éléments de menu
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

}
