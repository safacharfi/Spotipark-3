import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/User/booking/screens/ticket_view.dart';
import '/User/booking/utils/app_info_list.dart';
import '/User/booking/utils/app_layout.dart';
import '/User/booking/utils/app_styles.dart';
import '/User/booking/widgets/column_layout.dart';

import '/User/booking/widgets/ticket_tabs.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../widgets/layout_builder_widget.dart';
import 'package:provider/provider.dart';
import '../contract_linking.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getHeight(context, 20),
              vertical: AppLayout.getHeight(context, 20),
            ),
            children: [
              Gap(AppLayout.getHeight(context, 30)),
              // Image widget instead of text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Replace the text with an image
                  Center(
                    child: Image.asset(
                      'assets/images/available.png',
                      width: 400, // Adjust width as needed
                      height: 200, // Adjust height as needed
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: hotelList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildHotelTicketItem(
                            context, index, contractLink);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 1,
              ),

              Gap(AppLayout.getHeight(context, 30)),
              Container(
                padding:
                    EdgeInsets.only(left: AppLayout.getHeight(context, 15)),
              ),
            ],
          ),
          Positioned(
            left: AppLayout.getHeight(context, 22),
            top: AppLayout.getHeight(context, 295),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.textColor, width: 2)),
              child: CircleAvatar(
                maxRadius: 4,
                backgroundColor: Styles.textColor,
              ),
            ),
          ),
          Positioned(
            right: AppLayout.getHeight(context, 22),
            top: AppLayout.getHeight(context, 295),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.textColor, width: 2)),
              child: CircleAvatar(
                maxRadius: 4,
                backgroundColor: Styles.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHotelTicketItem(
      BuildContext context, int index, ContractLinking contractLink) {
    // Retrieve hotel information
     if (index < 0 || index >= hotelList.length) {
    return SizedBox(); // Retournez un widget vide si l'index est invalide
  }
    Map<String, dynamic> hotel = hotelList[index];

    List<String> availableRooms = List<String>.generate(
        hotel['availableRooms'], (roomIndex) => hotel['roomNames'][roomIndex]);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(
              'assets/images/box.png'), // Add your box image path here
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align children in center horizontally
        children: [
          Text(
            "Spot Category: ${hotel['place']}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            "Available Spots:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          // Display names of available rooms
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: availableRooms.map((roomName) {
              return Text(
                roomName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF051d40),
                ),
                textAlign: TextAlign.center,
              );
            }).toList(),
          ),
          SizedBox(height: 5),
          Text(
            contractLink.allAdopters[index] ==
                    "0x0000000000000000000000000000000000000000"
                ? "Adopted By: Not Adopted"
                : "Adopted By: ${contractLink.allAdopters[index].toString().substring(0, 5)}XXXXX",
            style: TextStyle(
              fontSize: 16,
              color: contractLink.allAdopters[index] ==
                      "0x0000000000000000000000000000000000000000"
                  ? Colors.white
                  : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
