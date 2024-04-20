import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../contract_linking.dart';
import '../utils/app_info_list.dart';
import '/User/booking/screens/hotels_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/spot.png',
                              width: 400,
                              height: 200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Discover our range of parking options designed to cater to your needs. Whether you prefer premium convenience or budget-friendly choices, we have something for everyone:",
                    style: TextStyle(
                      fontSize: 16,
                      // You can set other text properties here if needed
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text(
                          "Premium Valet Parking  - Closest to the main entrance for ultimate convenience.",
                          style: TextStyle(fontFamily: 'Courgette'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.star_border),
                        title: Text(
                          "Express Parking  - Convenient spots near the entrance for quick access.",
                          style: TextStyle(fontFamily: 'Courgette'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.star_half),
                        title: Text(
                          "Standard Parking - Easy access at a reasonable price.",
                          style: TextStyle(fontFamily: 'Courgette'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          "Economy Parking  - Budget-friendly options a short walk from the entrance.",
                          style: TextStyle(fontFamily: 'Courgette'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: hotelList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final singleHotel = entry.value;

                  return GestureDetector(
                    onTap: () {
                      adoptCatDialog(context, index, "${singleHotel['place']}");
                    },
                    child: HotelScreen(hotel: singleHotel),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Total Amount to Pay'),
                          content: Text('Total:  ${contractLink.totalAmount} /Dt'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Total amount to pay'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0XFF2B224B)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void adoptCatDialog(BuildContext context, int index, String hotelName) async {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController accountAddr = TextEditingController();
    TextEditingController duration = TextEditingController();
    TextEditingController startTime = TextEditingController();

    Map<String, dynamic> singleHotel = hotelList[index];

    int availableRooms = singleHotel['availableRooms'] ?? 0;
    if (availableRooms <= 0) {
      showToast("Sorry, $hotelName is fully booked.", context);
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Book $hotelName",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                child: TextField(
                  controller: accountAddr,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Account Address",
                    hintText: "Enter Account Address...",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                child: TextField(
                  controller: duration,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Duration (hours)",
                    hintText: "Enter Duration...",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                child: TextField(
                  controller: startTime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Start Time",
                    hintText: "Enter Start Time...",
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        contractLink.currentHotelPrice = singleHotel['price'];
                        int totalprice = await contractLink.calculateAmountToPay(
                            duration.text, contractLink.currentHotelPrice);
                        contractLink.adoptFunc(
                          index,
                          accountAddr.text,
                          duration.text,
                          startTime.text,
                        );
                        singleHotel['isAdopted'] = true;
                        singleHotel['availableRooms'] = availableRooms - 1;
                        String message =
                            "Thanks For Booking $hotelName. Total amount to pay: $totalprice";
                        showToast(message, context);
                        Navigator.pop(context);

                        // Start checking the time
                        startTimer(duration.text, startTime.text, context);
                      },
                      child: Text("Book"),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void startTimer(String durationText, String startTimeText, BuildContext context) {
    Timer.periodic(Duration(minutes: 1), (timer) {
      int durationHours = int.tryParse(durationText) ?? 0;
      DateTime startDateTime = DateTime.parse(startTimeText);
      DateTime endDateTime = startDateTime.add(Duration(hours: durationHours));
      DateTime currentDateTime = DateTime.now();

      if (currentDateTime.isAfter(endDateTime)) {
        showToast("You have exceeded the booked duration. Additional charges may apply.", context);
        timer.cancel();
      }
    });
  }

  void showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.teal,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}


