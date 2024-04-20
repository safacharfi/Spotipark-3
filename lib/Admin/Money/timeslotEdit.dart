import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/Admin/Money/Timeslot.dart';
import '/Admin/Money/TimeslotLinking.dart';
import '/Admin/Money/timeslot_home_screen.dart';
import '../screens/addLandInspector.dart';

class TimeslotsEditScreen extends StatefulWidget {
  final Timeslot? timeslot;

  TimeslotsEditScreen({this.timeslot, Key? key}) : super(key: key);

  @override
  State<TimeslotsEditScreen> createState() => _TimeslotsEditScreenState();
}

class _TimeslotsEditScreenState extends State<TimeslotsEditScreen> {
  late TextEditingController _durationController;
  late TextEditingController _priceController;
  late TimeslotController timeslotsController;

  @override
  void initState() {
    super.initState();
    _durationController = TextEditingController(
        text: widget.timeslot != null ? widget.timeslot!.duration : '');
    _priceController = TextEditingController(
        text: widget.timeslot != null ? widget.timeslot!.Price : '');
  }

  handleSaveTimeslot() async {
    if (widget.timeslot == null) {
      await handleCreateTimeslot();
    } else {
      await handleEditTimeslot();
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AddLandInspector()),
        (route) => false);
  }

  handleCreateTimeslot() async {
    Timeslot timeslot = Timeslot(
      '0',
      duration: _durationController.text,
      Price: _priceController.text,
    );
    await timeslotsController.addTimeslot(timeslot);
  }

  handleEditTimeslot() async {
    Timeslot timeslot = Timeslot(
      widget.timeslot!.id,
      duration: _durationController.text,
      Price: _priceController.text,
    );
    await timeslotsController.editTimeslot(timeslot);
  }

  @override
  Widget build(BuildContext context) {
    timeslotsController = Provider.of<TimeslotController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: timeslotsController.isLoading
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
                              onTap:handleSaveTimeslot,

                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    widget.timeslot == null
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
                          controller: _durationController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Duration',
                            hintText: 'Enter duration',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Price',
                            hintText: 'Enter price',
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
