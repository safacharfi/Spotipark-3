import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'Parking.dart';

class ParkingController extends ChangeNotifier {
  List<Parking> parkings = [];
  bool isLoading = true;
  late int count;
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0xf7fb8d9eebe6a811266fad95824793f65ab4419c4cd0651182b20dbfb96a1bfa";

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;
  // Define functions
  late ContractFunction _count;
  late ContractFunction _parkings;
  late ContractFunction _addParking;
  late ContractFunction _deleteParking;
  late ContractFunction _editParking;
  late ContractEvent _parkingAddedEvent;
  late ContractEvent _parkingDeletedEvent;

  ParkingController() {
    init();
  }

  Future<void> init() async {
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/contracts/Parking.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Parking"), _contractAddress);
    _count = _contract.function("ParkingCount");
    _parkings = _contract.function("parkings");
    _addParking = _contract.function("addParking");
    _deleteParking = _contract.function("deleteParking");
    _editParking = _contract.function("editParking");
    _parkingAddedEvent = _contract.event("ParkingAdded");
    _parkingDeletedEvent = _contract.event("ParkingDeleted");
    await getParkings();
  }

  Future<void> getParkings() async {
    List parkingList =
        await _client.call(contract: _contract, function: _count, params: []);
    BigInt totalparkings = parkingList[0];
    count = totalparkings.toInt();
    debugPrint("count $count");
    parkings.clear();
    for (int i = 0; i < count; i++) {
      var temp = await _client.call(
          contract: _contract, function: _parkings, params: [BigInt.from(i)]);
      if (temp[1] != "") {
        parkings.add(
          Parking(
            temp[0].toString(),
            name: temp[1],
            location: temp[2],
            capacity: temp[3],
          ),
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addParking(Parking parking) async {
    debugPrint("creating new parking: name- ${parking.name}");
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addParking,
            parameters: [parking.name, parking.location, parking.capacity],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getParkings();
  }

  Future<void> deleteParking(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _deleteParking,
            parameters: [BigInt.from(id)],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getParkings();
  }

  Future<void> editParking(Parking parking) async {
    isLoading = true;
    notifyListeners();
    print(BigInt.from(int.parse(parking.id)));
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _editParking,
            parameters: [
              BigInt.from(int.parse(parking.id)),
              parking.name,
              parking.location,
              parking.capacity
            ],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    ;
    await getParkings();
  }
}
