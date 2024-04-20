import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'Vehicle.dart';

class VehicleController extends ChangeNotifier {
  List<Vehicle> vehicles = [];
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
  late ContractFunction _vehicles;
  late ContractFunction _addVehicle;
  late ContractFunction _deleteVehicle;
  late ContractFunction _editVehicle;
  late ContractEvent _vehicleAddedEvent;
  late ContractEvent _vehicleDeletedEvent;

  VehicleController() {
    init();
  }

  Future<void> init() async {
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/contracts/SmartParking.json");
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
        ContractAbi.fromJson(_abiCode, "SmartParking"), _contractAddress);
    _count = _contract.function("vehicleCount");
    _vehicles = _contract.function("vehicles");
    _addVehicle = _contract.function("addVehicle");
    _deleteVehicle = _contract.function("deleteVehicle");
    _editVehicle = _contract.function("editVehicle");
    _vehicleAddedEvent = _contract.event("VehicleAdded");
    _vehicleDeletedEvent = _contract.event("VehicleDeleted");
    await getVehicles();
  }

  Future<void> getVehicles() async {
    List vehicleList =
        await _client.call(contract: _contract, function: _count, params: []);
    BigInt totalvehicles = vehicleList[0];
    count = totalvehicles.toInt();
    debugPrint("count $count");
    vehicles.clear();
    for (int i = 0; i < count; i++) {
      var temp = await _client.call(
          contract: _contract, function: _vehicles, params: [BigInt.from(i)]);
      if (temp[1] != "") {
        vehicles.add(
          Vehicle(
            temp[0].toString(),
            brand: temp[1],
            lisencePlate: temp[2],
            model: temp[3],
          ),
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    debugPrint(
        "creating new Vehicle: name- ${vehicle.brand}, company- ${vehicle.lisencePlate}, phone- ${vehicle.model}");
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addVehicle,
            parameters: [vehicle.brand, vehicle.lisencePlate, vehicle.model],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getVehicles();
  }

  Future<void> deleteVehicle(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _deleteVehicle,
            parameters: [BigInt.from(id)],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getVehicles();
  }

  Future<void> editVehicle(Vehicle vehicle) async {
    isLoading = true;
    notifyListeners();
    print(BigInt.from(int.parse(vehicle.id)));
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _editVehicle,
            parameters: [
              BigInt.from(int.parse(vehicle.id)),
              vehicle.brand,
              vehicle.lisencePlate,
              vehicle.model
            ],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    ;
    await getVehicles();
  }
}
