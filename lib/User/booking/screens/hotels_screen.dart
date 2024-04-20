import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/User/booking/utils/app_layout.dart';
import '/User/booking/utils/app_styles.dart';

class HotelScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;
  const HotelScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/back.png', // path to your background image
            fit: BoxFit.cover,
          ),
        ),
        // Hotel Screen Content
        Container(
          width: size.width * 0.6,
          height: AppLayout.getHeight(context, 340),
          padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(context, 15),
              vertical: AppLayout.getHeight(context, 17)),
          margin: const EdgeInsets.only(right: 17, top: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFCCCCFF),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/box.png'), // Add your box image path here
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: AppLayout.getHeight(context, 180),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Styles.primaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/${hotel['image']}"),
                    )),
              ),
              const Gap(10),
              Text(hotel['place'],
                  style: Styles.headLineStyle2.copyWith(
                    color: Color(0xFF051D40),
                  )),
              const Gap(5),
              Text(
                "${hotel['price']} DT/Hour",
                style: Styles.headLineStyle1.copyWith(color: Colors.black),
              ),
              const Gap(2),
            ],
          ),
        ),
      ],
    );
  }
}
