import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '/User/booking/utils/app_layout.dart';
import '/User/booking/utils/app_styles.dart';
import '/User/booking/widgets/double_text_widget.dart';
import 'home_screen.dart'; // Importez votre écran d'accueil ici
import 'ticket_screen.dart'; // Importez votre écran de ticket ici

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/back.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getWidth(context, 20),
              vertical: 0, // Removed top padding
            ),
            children: [
              Image.asset(
                "assets/images/time.png",
                height: 350,
                width: 600,
              ),
              Gap(AppLayout.getHeight(context, 25)),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getHeight(
                      context, 8), // Adjusted padding vertical value
                  horizontal: AppLayout.getHeight(
                      context, 3), // Adjusted padding horizontal value
                ),
                decoration: BoxDecoration(
                  color: const Color(0XFF2B224B),
                  borderRadius: BorderRadius.circular(AppLayout.getHeight(
                      context, 6)), // Adjusted border radius value
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Book a spot ',
                      style: Styles.textStyle.copyWith(
                        color: Colors.white,
                        fontSize: AppLayout.getWidth(context, 20),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(context, 40)),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TicketScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppLayout.getHeight(
                        context, 8), // Adjusted padding vertical value
                    horizontal: AppLayout.getHeight(
                        context, 3), // Adjusted padding horizontal value
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0XFF2B224B),
                    borderRadius: BorderRadius.circular(AppLayout.getHeight(
                        context, 6)), // Adjusted border radius value
                  ),
                  child: Center(
                    child: Text(
                      'Available spots',
                      style: Styles.textStyle.copyWith(
                        color: Colors.white,
                        fontSize: AppLayout.getWidth(context, 20),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(AppLayout.getHeight(context, 40)),
              const AppDoubleTextWidget(
                bigText: "Spotipark's latest discounts",
                smallText: "",
              ),
              Gap(AppLayout.getHeight(context, 15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: AppLayout.getHeight(context, 400),
                    width: size.width * 0.42,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppLayout.getHeight(context, 15),
                      vertical: AppLayout.getHeight(context, 15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          AppLayout.getHeight(context, 20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: AppLayout.getHeight(context,
                              250), // Increase the height for a larger image
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(context, 12)),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/fly.jpg"),
                            ),
                          ),
                        ),
                        Gap(AppLayout.getHeight(context, 12)),
                        Text(
                          "Get app-exclusive rewards after 3 bookings! Don't miss out.",
                          style: Styles.headLineStyle2.copyWith(
                              fontSize: 16), // Reduce the font size of the text
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: AppLayout.getHeight(context, 200),
                            decoration: BoxDecoration(
                              color: const Color(0xFF76B9F0),
                              borderRadius: BorderRadius.circular(
                                  AppLayout.getHeight(context, 18)),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppLayout.getHeight(context, 15),
                              horizontal: AppLayout.getHeight(context, 15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discount on\nAll bookings on Monday ",
                                  style: Styles.headLineStyle2.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Gap(AppLayout.getHeight(context, 10)),
                                Text(
                                  "Register and book your spot quickly.",
                                  style: Styles.headLineStyle2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -45,
                            top: -40,
                            child: Container(
                              padding: EdgeInsets.all(
                                  AppLayout.getHeight(context, 30)),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 18,
                                  color: const Color(0xFF189999),
                                ),
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(AppLayout.getHeight(context, 10)),
                      Container(
                        width: size.width * 0.44,
                        height: AppLayout.getHeight(context, 190),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5271FF),
                          borderRadius: BorderRadius.circular(
                              AppLayout.getHeight(context, 18)),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: AppLayout.getHeight(context, 15),
                          horizontal: AppLayout.getHeight(context, 15),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.emoji_emotions_rounded,
                                color: Color(0xFF102D4D),
                              ),
                              Gap(AppLayout.getHeight(context, 10)),
                              Text(
                                "Thank You\nfor Visiting app",
                                textAlign: TextAlign.center,
                                style: Styles.headLineStyle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
