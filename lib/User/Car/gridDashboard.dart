import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'VehiculeLinking.dart';
import 'Vehicle.dart';
import '/User/Car/Vehicledetail.dart';

class GridDashboard extends StatelessWidget {
  late List<Vehicle> vehicles;

  @override
  Widget build(BuildContext context) {
    VehicleController contactController =
        Provider.of<VehicleController>(context, listen: true);
    vehicles = contactController.vehicles;

    debugPrint("vehicles size ${vehicles.length}");

    return Flexible(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
        ),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          Vehicle vehicle = vehicles[index];
          return GestureDetector(
            onTap: () {
              // Naviguez vers la page de détail en passant le véhicule correspondant
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>VehicleDetailScreen(vehicle: vehicle),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF15256e), // Specify the color code here
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/calender.png",
                    width: 52,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Brand: ${vehicle.brand}',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'License Plate: ${vehicle.lisencePlate}', // Corrected typo in 'licensePlate'
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Model: ${vehicle.model}',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
