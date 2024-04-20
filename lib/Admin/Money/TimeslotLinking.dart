import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'Timeslot.dart';

class TimeslotController extends ChangeNotifier {
  List<Timeslot> timeslots = [];
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
  late ContractFunction _timeslots;
  late ContractFunction _addTimeslot;
  late ContractFunction _deleteTimeslot;
  late ContractFunction _editTimeslot;
  late ContractEvent _timeslotAddedEvent;
  late ContractEvent _timeslotDeletedEvent;

  TimeslotController() {
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
    _count = _contract.function("timeslotCount");
    _timeslots = _contract.function("timeslots");
    _addTimeslot = _contract.function("addTimeslot");
    _deleteTimeslot = _contract.function("deleteTimeslot");
    _editTimeslot = _contract.function("editTimeslot");
    _timeslotAddedEvent = _contract.event("TimeslotAdded");
    _timeslotDeletedEvent = _contract.event("TimeslotDeleted");
    await getTimeslots();
  }

  Future<void> getTimeslots() async {
    List timeslotList =
        await _client.call(contract: _contract, function: _count, params: []);
    BigInt totaltimeslots = timeslotList[0];
    count = totaltimeslots.toInt();
    debugPrint("count $count");
    timeslots.clear();
    for (int i = 0; i < count; i++) {
      var temp = await _client.call(
          contract: _contract, function: _timeslots, params: [BigInt.from(i)]);
      if (temp[1] != "") {
        timeslots.add(
          Timeslot(
            temp[0].toString(),
            duration: temp[1],
            Price: temp[2],
          ),
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTimeslot(Timeslot timeslot) async {
    debugPrint(
        "creating new Timeslot: name- ${timeslot.duration}, company- ${timeslot.Price}");
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addTimeslot,
            parameters: [timeslot.duration, timeslot.Price],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getTimeslots();
  }

  Future<void> deleteTimeslot(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _deleteTimeslot,
            parameters: [BigInt.from(id)],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getTimeslots();
  }

  Future<void> editTimeslot(Timeslot timeslot) async {
    isLoading = true;
    notifyListeners();
    print(BigInt.from(int.parse(timeslot.id)));
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _editTimeslot,
            parameters: [
              BigInt.from(int.parse(timeslot.id)),
              timeslot.duration,
              timeslot.Price,
            ],
            maxGas: 6721975),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    ;
    await getTimeslots();
  }
}
