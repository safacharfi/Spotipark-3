import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'TimeslotLinking.dart';
import 'Timeslotdetail.dart';
import '/Admin/Money/TimeslotEdit.dart';
import 'Timeslot.dart';
import '../constant/utils.dart';
import 'timeslot_home_screen.dart';
import '../Parkinglot/home_screen.dart';
import '../screens/addLandInspector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TimeslotController timeslotController;
  late List<Timeslot> timeslots;
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
    timeslotController = Provider.of<TimeslotController>(context, listen: true);
    timeslots = timeslotController.timeslots;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return largeScreenLayout();
        } else {
          return smallScreenLayout();
        }
      },
    );
  }

  Widget largeScreenLayout() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TimeslotsEditScreen(),
            ),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color:Color(0xFFEEC705),
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Center(
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEFEF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFEEC705),
        title: const Text(
          'Manage Tariffs',
        ),
      ),
      drawer: drawer2(),
      drawerScrimColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: timeslotController.isLoading
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
                  children: const [
                    Text(
                      "Your Timeslots",
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: timeslots.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            const Divider(height: 15),
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
                                    child: Text(
                                      'Duration',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Price',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                            const Divider(height: 15)
                          ],
                        );
                      }
                      final timeslot = timeslots[index - 1];
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
                                child: Text('${timeslot.duration}'),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text('${timeslot.Price}'),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TimeslotDetailScreen(
                                timeslot: timeslot,
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

  Widget smallScreenLayout() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFEEC705),
        title: const Text(
          'Manage Tariffs',
        ),
      ),
      drawer: drawer2(),
      drawerScrimColor: Colors.transparent,
      body: Center(
        child: Text('Your small screen layout here'),
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
                      // Handle navigation based on selected menu item
                      if (index == 0) {
                        // If selected menu item is "Add Admin"
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddLandInspector()));
                      } else if (index == 3) {
                        // For example, if selected menu item is "Parking Management"
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ParkingScreen()));
                      } else if (index == 4) {
                        // If selected menu item is "Tariff Management"
                        // You can add other cases here for other menu items
                      }
                      // You can add other cases here to handle navigation for other menu items
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
