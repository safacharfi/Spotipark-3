import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:land_registration/User/Car/listVehicule.dart';
import 'package:land_registration/User/booking/contract_linking.dart';
import '/User/Authentification/screens/cart_screen.dart';
import '/User/Authentification/screens/home_screen.dart';
import '/User/Authentification/screens/login_screen.dart';
import '/User/Authentification/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '/User/Authentification/screens/UserLinking.dart'; // Importer le UserController
import '/User/balance/presentation/pages/BalanceLinking.dart';
import 'User/Car/VehiculeLinking.dart';
import '/landingScreen/screens/home/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'landingScreen/screens/home/home.dart';
import 'User/Authentification/screens/UserLinking.dart';
import 'User/balance/presentation/pages/BalanceLinking.dart';
import 'User/Car/VehiculeLinking.dart';
import '/User/Car/VehiculeLinking.dart';
import '/User/booking/contract_linking.dart';
import '/User/balance/presentation/pages/BalanceLinking.dart';
import '/User/metamask.dart';


void main() {
  runApp(
    MultiProvider(
          providers: [
       
          ChangeNotifierProvider<UserController>(
            create: (_) => UserController(),
          ),
           ChangeNotifierProvider<VehicleController>(
            create: (_) => VehicleController(),
          ),
           ChangeNotifierProvider<balanceLinking>(
            create: (_) => balanceLinking(),
          ),
          ChangeNotifierProvider<ContractLinking>(
            create: (_) => ContractLinking(),
          ),
        
          ChangeNotifierProvider<MetaMaskProviderU>(
            create: (context) => MetaMaskProviderU()..init(),
          ),
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const String title = 'My App Title';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          home: BoardingScreen(),
        );
        
      },
    );
    
  }
}
