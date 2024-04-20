import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'parkinglotLinking.dart';
import 'parkinglotEdit.dart';
import 'Parking.dart';

class ParkingDetailScreen extends StatefulWidget {
  Parking? parking;

  ParkingDetailScreen({this.parking, super.key});

  @override
  State<ParkingDetailScreen> createState() => _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends State<ParkingDetailScreen> {
  late ParkingController noteController;

  handleDeleteNote() async {
    await noteController.deleteParking(int.parse(widget.parking!.id));
    Navigator.of(context).pop(); // Pop dialog after deletion
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Delete',
            
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this parking lot?',
                
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: Text(
                'No',
                
              ),
            ),
            TextButton(
              onPressed: () {
                handleDeleteNote(); // Delete vehicle
                Navigator.of(context).pop(); // Pop dialog
                Navigator.of(context).pop(); // Pop detail screen
              },
              child: Text(
                'Yes',
               
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    noteController = Provider.of<ParkingController>(context);
    return Scaffold(
      backgroundColor: Color(0xFFDCE9EF), // Add background color here
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ParkingsEditScreen(parking: widget.parking),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          _showDeleteConfirmationDialog();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.parking!.name,
                  
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.parking!.location,
                    
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.parking!.capacity, // Convert capacity to string
                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
