import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Parking.dart';
import 'parkinglotLinking.dart';
import 'home_screen.dart';
import '../screens/addLandInspector.dart';

class ParkingsEditScreen extends StatefulWidget {
  final Parking? parking;

  ParkingsEditScreen({this.parking, Key? key}) : super(key: key);

  @override
  State<ParkingsEditScreen> createState() => _ParkingsEditScreenState();
}

class _ParkingsEditScreenState extends State<ParkingsEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _capacityController;
  late ParkingController parkingsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.parking != null ? widget.parking!.name : '');
    _locationController = TextEditingController(
        text: widget.parking != null ? widget.parking!.location : '');
    _capacityController = TextEditingController(
        text: widget.parking != null
            ? widget.parking!.capacity
            : ''); // Capacity treated as a string
  }

  handleSaveParking() async {
    if (widget.parking == null) {
      await handleCreateParking();
    } else {
      await handleEditParking();
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AddLandInspector()),
        (route) => false);
  }

  handleCreateParking() async {
    Parking parking = Parking(
      '0',
      name: _nameController.text,
      location: _locationController.text,
      capacity: _capacityController.text, // Capacity treated as a string
    );
    await parkingsController.addParking(parking);
  }

  handleEditParking() async {
    Parking parking = Parking(
      widget.parking!.id,
      name: _nameController.text,
      location: _locationController.text,
      capacity: _capacityController.text, // Capacity treated as a string
    );
    await parkingsController.editParking(parking);
  }

  @override
  Widget build(BuildContext context) {
    parkingsController = Provider.of<ParkingController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: parkingsController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            GestureDetector(
                              onTap: handleSaveParking,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    widget.parking == null
                                        ? 'Add Parking'
                                        : 'Save Changes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
            color:Color(0xFFEEC705),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            hintText: 'Enter Parking name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location',
                            hintText: 'Enter location',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _capacityController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Capacity',
                            hintText: 'Enter capacity',
                          ),
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
