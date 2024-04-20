import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0xf7fb8d9eebe6a811266fad95824793f65ab4419c4cd0651182b20dbfb96a1bfa";

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;

  late DeployedContract _contract;
  late ContractFunction _adopterGetter;
  late ContractFunction _adoptFunc;
  late ContractFunction _getAdoptersFunc;
  late ContractFunction _calculateAmountToPay;
  late ContractFunction _payFunc; // Ajout de _payFunc

  late List allAdopters = [];
  late int totalAmount = 0;
  late int currentHotelPrice = 0;
  late int currentbalance;

  late bool isLoading = true;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/contracts/SmartParking.json");
    var jsonFile = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "SmartParking"), _contractAddress);
    _adopterGetter = _contract.function("adopters");
    _adoptFunc = _contract.function("adopt");
    _getAdoptersFunc = _contract.function("getAdopters");
    _calculateAmountToPay = _contract.function("calculateAmountToPay");
    _payFunc = _contract.function("send "); // Initialisation de _payFunc
    getAdoptersFunc();
  }

  getAdoptersFunc() async {
    var adopterS = await _client
        .call(contract: _contract, function: _getAdoptersFunc, params: []);
    isLoading = false;
    allAdopters = adopterS.first;
    print(allAdopters[0]);
    notifyListeners();
  }

  Future<String> getAdopter(int id) async {
    var adopterIs = await _client.call(
        contract: _contract,
        function: _adopterGetter,
        params: [BigInt.from(id)]);
    notifyListeners();
    return "${adopterIs.first}";
  }

  adoptFunc(
      int id, String adopterAddr, String duration, String startTime) async {
    isLoading = false;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _adoptFunc,
            parameters: [
              BigInt.from(id),
              EthereumAddress.fromHex(adopterAddr),
              duration,
              startTime
            ],
            maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);
    int amountToPay = await calculateAmountToPay(duration, currentHotelPrice);
    totalAmount += amountToPay;
    getAdoptersFunc();
  }

  Future<int> calculateAmountToPay(String duration, int price) async {
    try {
      var result = await _client.call(
        contract: _contract,
        function: _calculateAmountToPay,
        params: [duration, BigInt.from(price)], // Convertir 'price' en BigInt
      );

      // Vérifier si le résultat est une liste contenant un élément de type BigInt
      if (result is List && result.isNotEmpty && result[0] is BigInt) {
        // Extraire le BigInt de la liste et le convertir en int
        BigInt bigIntResult = result[0];
        return bigIntResult.toInt();
      } else {
        throw Exception("Unexpected result format: $result");
      }
    } catch (e) {
      print("Error calculating amount to pay: $e");
      throw e; // Propagez l'erreur pour la gérer à un niveau supérieur si nécessaire
    }
  }

  Future<int> payCoins(int balance, int amount) async {
    try {
      // Envoyer une transaction au contrat intelligent pour effectuer le paiement
      final result = await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: _contract,
          function: _payFunc,
          parameters: [BigInt.from(amount), BigInt.from(balance)],
          maxGas: 1000000,
        ),
        chainId: 1337,
        fetchChainIdFromNetworkId: false,
      );

      // Traiter le résultat si nécessaire
      // Si le résultat est une transaction réussie, vous pouvez renvoyer un code de statut ou un identifiant de transaction
      // Par exemple, vous pouvez retourner l'identifiant de transaction si vous en avez besoin pour une quelconque vérification ultérieure.
      return int.parse(result);
    } catch (e) {
      // En cas d'erreur lors de l'envoi de la transaction
      print("Erreur lors du paiement des coins: $e");
      // Propagez l'erreur pour la gérer à un niveau supérieur si nécessaire
      throw e;
    }
  }
}
