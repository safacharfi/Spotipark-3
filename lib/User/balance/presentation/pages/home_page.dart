import 'package:flutter/material.dart';
import '../../common/gap.dart';
import '../../common/skeleton.dart';
import '../../common/static.dart';
import '../../data/model/saving_target_model.dart';
import '../../data/model/transaction_model.dart';
import '../../data/repository/repository.dart';
import '../../style/color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../style/typography.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:skeletons/skeletons.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Authentification/screens/UserLinking.dart';
import '../../../Authentification/screens/User.dart';
import 'package:provider/provider.dart';
import '../../../Authentification/profile/newprofilepage.dart';
import 'BalanceLinking.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State<BalancePage> createState() => _HomePageState();
}

class _HomePageState extends State<BalancePage> {
  bool _isLoad = true;
  bool _isHidden = true;
  bool _isMore = true;
  late UserController contactController;
  late List<User> users;
  late Size size;

  // Define a list of maps containing the icon name and the icon itself
  final List<Map<String, dynamic>> widgetIcons = [
    {'name': 'check balance', 'icon': Icons.account_balance},
    {'name': 'Receive', 'icon': Icons.move_to_inbox_outlined},
  ];

  void handleClick(int index) {
    switch (index) {
      case 0:
        balanceDialog(context);
        break;
      case 1:
        mintCoinDialog(context);
        break;
      default:
        break;
    }
  }

  void isLoadingSuccess() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isLoadingSuccess();
  }

  @override
  Widget build(BuildContext context) {
    // Add this line to get the instance of balanceLinking
    var balanceLink = Provider.of<balanceLinking>(context);
    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/back.png', // Adjust the path to your image asset
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'images/balance.png',
                                width: 400,
                                height: 200,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        profileSection(),
                        const VerticalGap20(),
                        balanceSection(context),
                        const VerticalGap10(),
                        paymentSection(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Skeleton paymentSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const SmallSkeleton(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 12,
          ),
          itemCount: 2, // Remove the pay method and its associated icon
          itemBuilder: (context, index) {
            // Adjust the items accordingly if needed
            return InkWell(
              onTap: () {
                handleClick(index);
              },
              splashColor: buttonColor,
              highlightColor: buttonColor,
              focusColor: buttonColor,
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: primaryColor,
                    ),
                    child: Icon(widgetIcons[index]['icon']),
                  ),
                  const VerticalGap5(),
                  Expanded(
                    child: Text(
                      widgetIcons[index]['name'],
                      style: poppinsCaption.copyWith(
                        color: textColor.withOpacity(.75),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          shrinkWrap: true,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Skeleton balanceSection(BuildContext context) {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const MediumSkeleton(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Balance',
                  style: poppinsBody2.copyWith(
                    color: textColor.withOpacity(.75),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _isHidden ? '\$' : '---------',
                  style: poppinsH1.copyWith(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const HorizontalGap5(),
                InkWell(
                  onTap: () {
                    balanceDialog(context);
                    setState(() {
                      _isHidden = !_isHidden;
                    });
                  },
                  child: Icon(
                    _isHidden
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: textColor.withOpacity(.75),
                    size: 20,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _isMore
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const SizedBox(),
              secondChild: Column(
                children: [
                  const VerticalGap10(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: textColor.withOpacity(.25),
                  ),
                  const VerticalGap10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Investation (0,00%)',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                      Text(
                        'Rp 0',
                        style: poppinsH5.copyWith(
                          color: textColor.withOpacity(.75),
                        ),
                      ),
                    ],
                  ),
                  // Remove info icon and its information
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Skeleton profileSection() {
    return Skeleton(
      duration: const Duration(seconds: 2),
      isLoading: _isLoad,
      themeMode: ThemeMode.dark,
      darkShimmerGradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          secondaryColor,
          secondaryColor.withOpacity(.75),
          secondaryColor,
        ],
        tileMode: TileMode.repeated,
      ),
      skeleton: const SmallSkeleton(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalGap20(), // Add vertical spacing here
          Text(
            'Track Your funds: Secure and Transparent 🎆',
            style: poppinsBody2.copyWith(
              color: textColor.withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}

void balanceDialog(BuildContext context) {
  var balanceLink = Provider.of<balanceLinking>(context, listen: false);
  TextEditingController accountAddr = TextEditingController();
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Check Balance",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: accountAddr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Account Address",
                      hintText: "Enter Your Account Address..."),
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
                      child: const Text("Cancel")),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          String balance =
                              await balanceLink.getBalance(accountAddr.text);
                          print(balance);
                          showToast(
                              "${accountAddr.text.substring(0, 5)}XXXX has $balance Dinars.",
                              context);
                          //Navigator.pop(context);
                        },
                        child: const Text("Balance")),
                  )
                ],
              )
            ],
          ),
        );
      });
}

void mintCoinDialog(BuildContext context) {
  var balanceLink = Provider.of<balanceLinking>(context, listen: false);
  TextEditingController accountAddr = TextEditingController();
  TextEditingController coinsAmount = TextEditingController();
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Money to Card",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                child: TextField(
                  controller: accountAddr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Account Address",
                      hintText: "Enter Account Address..."),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: coinsAmount,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Amount in DT",
                      hintText: "Enter Money Amount To recive..."),
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
                      child: const Text("Cancel")),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          balanceLink.mintCoins(
                              accountAddr.text, int.parse(coinsAmount.text));
                          showToast(
                              "Dinars ${coinsAmount.text} Sent to ${accountAddr.text.substring(0, 5)}XXXX",
                              context);
                          Navigator.pop(context);
                        },
                        child: const Text("Recive")),
                  )
                ],
              )
            ],
          ),
        );
      });
}

showToast(String message, BuildContext context) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    textColor: Colors.white,
    fontSize: 20,
  );
}
