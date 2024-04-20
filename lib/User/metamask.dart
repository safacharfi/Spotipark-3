import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_web3/flutter_web3.dart';
import '/User/constants.dart' as constant;

class MetaMaskProviderU extends ChangeNotifier {
  static const operatingChain = constant.chainId;
  String contractAddress = constant.contractAddress;
  String? currentAddress; // Use nullable type for safety
  int currentChain = -1;
  Contract? contract; // Initialize as null

  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress != null;

  final abi = [
    "function send(address sender, address receiver, uint amount) public",
  ];

  Future<void> connect() async {
    if (isEnabled) {
      try {
        final accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) {
          currentAddress = accs.first;
          currentChain = await ethereum!.getChainId();

          final provider = Web3Provider(ethereum!);
          contract = Contract(
            contractAddress,
            Interface(abi),
            provider.getSigner(),
          );
          notifyListeners();
        }
      } catch (e) {
        print('Error connecting to MetaMask: $e');
        // Handle errors here, e.g., display a user-friendly message
      }
    }
  }

  void clear() {
    currentAddress = null;
    currentChain = -1;
    contract = null; // Clear the contract instance
    notifyListeners();
  }

  void init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
        showToast('Account Changed\nPlease Login Again', backgroundColor: Colors.redAccent);
      });
      ethereum!.onChainChanged((accounts) {
        clear();
        showToast('Network Changed\nPlease Login Again', backgroundColor: Colors.redAccent);
      });
    }
  }

  Future<void> makePayment(String sender, String receiver, int amount) async {
    if (isConnected) {
      try {
        final tx = await contract!.send(
          'send',
          [sender, receiver, BigInt.from(amount)], // Use BigInt for amount
          // TransactionOverride is unnecessary for `send` function
        );
        print('Transaction successful: $tx');
      } catch (e) {
        print('Error making payment: $e');
        // Handle errors here, e.g., inform the user
      }
    } else {
      print('Not connected to MetaMask');
      // Handle the case where MetaMask is not connected
    }
  }
}