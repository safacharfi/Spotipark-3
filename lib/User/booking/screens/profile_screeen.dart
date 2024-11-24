import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import '/User/booking/utils/app_layout.dart';
import '/User/booking/utils/app_styles.dart';
import '/User/booking/widgets/column_layout.dart';
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/User/booking/contract_linking.dart';
import '/User/balance/presentation/pages/BalanceLinking.dart';
import '/User/metamask.dart';
import '/User/constants.dart' as constant;
import '/User/balance/presentation/pages/BalanceLinking.dart'; // Import correct du module Balance

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/User/booking/contract_linking.dart';
import '/User/metamask.dart';
import '/User/constants.dart' as constant;



class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  _AmountScreenState createState() => _AmountScreenState();
}
class _AmountScreenState extends State<AmountScreen> {
  late TextEditingController _addressController;
  bool showPaymentButton = false;
  bool isPaymentInProgress = false;
  bool payementdone=false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    connectToMetaMask(); // Call the connect method when the screen initializes
  }

  void connectToMetaMask() async {
    var model2 = Provider.of<MetaMaskProviderU>(context, listen: false);
    await model2.connect(); // Assuming connect method is async
    setState(() {
      showPaymentButton = model2.isConnected; // Update the state based on connection status
    });
  }


  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    var totalAmount = contractLink.totalAmount;
    var model2 = Provider.of<MetaMaskProviderU>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        actions: [
          SizedBox(
            height: 40,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Transform.scale(
                scale: 1.2,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/profile.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/log.png'),
                                scale: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'My Booking Fees',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Your Smart Parking App',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0x0fffefe3),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF526799),
                                      ),
                                      child: Image.asset(
                                        'assets/images/coin.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'Fee Status ',
                                      style: TextStyle(
                                        color: Color(0xFF526799),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          Positioned(
                            top: -40,
                            right: -45,
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 18, color: Color(0xFF264CD2)),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  maxRadius: 25,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/icon.png',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' Protecting Your Payments',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Secure Transactions, Guaranteed Safety!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Column(
                        children: [
                          Text(
                            "We recognize that everyone has unique preferences. Whether you prefer credit cards or cryptocurrency, we’ve got you covered!",
                            style: TextStyle(
                              fontSize: 16,
                              // You can set other text properties here if needed
                            ),
                          ),
                          Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons
                                    .credit_card), // Change icon for Credit Card
                                title: Text(
                                  "Credit Card (in DT)",
                                  style: TextStyle(fontFamily: 'Courgette'),
                                ),
                                subtitle: Text(
                                  "You can conveniently pay for your parking using your credit card in DT (local currency).",
                                  style: TextStyle(fontFamily: 'Courgette'),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons
                                    .account_balance_wallet), // Change icon for Metamask Wallet
                                title: Text(
                                  "Metamask Wallet",
                                  style: TextStyle(fontFamily: 'Courgette'),
                                ),
                                subtitle: Text(
                                  "Connect your Metamask wallet and pay directly using cryptocurrency (Ether). By choosing this method, you’ll enjoy a special discount on parking fees.",
                                  style: TextStyle(fontFamily: 'Courgette'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      const SizedBox(height: 25),
                      Text(
                        'Your total parking Fees:',
                        style: GoogleFonts.courgette(
                          fontSize: 24, // Set the desired font size
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width:
                              300, // Adjust width according to your preference
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey.shade200,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/images/box.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                'Total: $totalAmount DT',
                                style: TextStyle(
                                  fontSize: 45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/metamask.png',
                              width: 380,
                              height: 250,
                            ),
                            const SizedBox(
                                height: 20), // Adjust spacing as needed
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
ElevatedButton(
  onPressed: isPaymentInProgress ? null : () async {
    try {
      await model2.connect();

      if (model2.isConnected) {
        final tx = await model2.makePayment(
          constant.contractAddress,
          '0x9e106Ecce9493a5c044A12212496fA98e1b4403E', // Remplacez par l'adresse du destinataire
          contractLink.totalAmount,
        ); 
        payementdone=true;
        contractLink.totalAmount -= totalAmount;
        setState(() {
          contractLink.totalAmount = 0;
        });

        // Affichage du message de succès après la confirmation de la transaction
      } 
    } catch (e) {
      // Gestion des erreurs
      print('Error making payment: $e');
      showToast('Payment failed: $e', context);
      setState(() {
        isPaymentInProgress = false; // Assurez-vous que le paiement est réinitialisé en cas d'erreur
      });
    }
  },
  child: const Text('Pay Now with MetaMask (crypto)'),
),

                                ElevatedButton(
                                  onPressed: () {
                                    sendCoinDialog(context);
                                  },
                                  child: const Text('Pay with Dinars'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendCoinDialog(BuildContext context) {
    var balanceLink =
        Provider.of<balanceLinking>(context, listen: false); // Correction here
    TextEditingController senderAddr = TextEditingController();
    var contractLink = Provider.of<ContractLinking>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Pay with DT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                child: TextField(
                  controller: senderAddr,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Sender Account Addr...",
                    hintText: "Enter Sender Account Address...",
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
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      balanceLink.sendCoins(
                        senderAddr.text,
                        constant.contractAddress,
                        contractLink.totalAmount,
                      );
                      showToast(
                        "Transferred from ${senderAddr.text.substring(0, 5)}XXXX to ${constant.contractAddress.substring(0, 5)}XXXX",
                        context,
                      );
                      Navigator.pop(context);

                      // Update totalAmount to zero
                      setState(() {
                        contractLink.totalAmount = 0;
                      });
                    },
                    child: const Text("Pay"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}
