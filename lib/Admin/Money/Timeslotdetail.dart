import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'TimeslotLinking.dart';
import '/Admin/Money/TimeslotEdit.dart';
import 'Timeslot.dart';

class TimeslotDetailScreen extends StatefulWidget {
  Timeslot? timeslot;

  TimeslotDetailScreen({this.timeslot, super.key});

  @override
  State<TimeslotDetailScreen> createState() => _TimeslotDetailScreenState();
}

class _TimeslotDetailScreenState extends State<TimeslotDetailScreen> {
  late TimeslotController noteController;

  handleDeleteNote() async {
    await noteController.deleteTimeslot(int.parse(widget.timeslot!.id));
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
                  'Are you sure you want to delete this timeslot?',
                  
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
                handleDeleteNote(); // Delete timeslot
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
    noteController = Provider.of<TimeslotController>(context);
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
                              builder: (context) => TimeslotsEditScreen(
                                  timeslot: widget.timeslot),
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
                    widget.timeslot!.duration,
                  
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.timeslot!.Price,
                  
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
