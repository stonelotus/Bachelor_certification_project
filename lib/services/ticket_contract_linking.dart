import 'dart:math';

import 'package:flutter/widgets.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/services/contract_linking.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class TicketingContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.68.61:7545";
  final String _wsUrl = "ws://192.168.68.61:7545/";
  final int _chainId = 1337;

  late Web3Client _client;
  late bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _getTicket;
  late ContractFunction _buyTicket;
  late ContractFunction _issueTicket;
  late ContractFunction _getOwner;
  late String deployedName;

  bool setupDone = false;

  String? _privateKey;

  TicketingContractLinking(String privateKey) {
    _privateKey = privateKey;
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    debugPrint('Setting up...');
    _client = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    ;
    debugPrint('Setup done!');
    await getAbi();
    getCredentials(_privateKey);
    debugPrint('ABI done!');
    await getDeployedContract();
    debugPrint('Got Deployed contract!');

    setupDone = true;
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString('src/artifacts/TicketingSystem.json');
    final jsonAbi = jsonDecode(abiStringFile) as Map<String, dynamic>;
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress = EthereumAddress.fromHex(
      jsonAbi['networks']['5777']['address'] as String,
    );
  }

  void getCredentials(privateKey) async {
    // _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _credentials = EthPrivateKey.fromHex(privateKey);
    debugPrint("Got credentials.");
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    _getTicket = _contract.function("getTicket");
    _buyTicket = _contract.function("buyTicket");
    _issueTicket = _contract.function("mint");
    _getOwner = _contract.function("getOwner");
    debugPrint("Extracted contract.");
  }

  getTicket(ticketId) async {
    // Calling the smart contract, in order to get our ticket.
    debugPrint("Getting ticket...");
    isLoading = true;
    notifyListeners(); // Notify listeners to update the UI.
    print("From this ID: $ticketId");
    final ticket = await _client.call(
      contract: _contract,
      function: _getTicket,
      params: [BigInt.from(ticketId)],
    );

    debugPrint("Got ticket: $ticket");
    isLoading = false;
    notifyListeners(); // Notify listeners to update the UI.

    return ticket;
  }

  buyTicket(ticketId) async {
    // Sending a transaction to our contract to get the ticket.
    debugPrint("Buying ticket...");
    isLoading = true;
    notifyListeners(); // Notify listeners to update the UI.

    var ticketObject = await getTicket(ticketId);
    debugPrint("Ticket object: $ticketObject");
    final ticketPrice = ticketObject[2];
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _buyTicket,
        parameters: [BigInt.from(ticketId)],
        value: EtherAmount.inWei(
            BigInt.from((0.01 * pow(10, 18)).toInt())), //Should be ticketPrice
      ),
      chainId: _chainId,
    );
  }

  issueTicket(name, price, batch_size, seats, date) async {
    // Sending a transaction to our contract to get the ticket.

    debugPrint("Issuing ticket...");
    isLoading = true;
    notifyListeners(); // Notify listeners to update the UI.

    String txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _issueTicket,
        parameters: [
          name,
          BigInt.from(price),
          BigInt.from(batch_size),
          BigInt.from(seats),
          BigInt.from(10) //TODO reverse
        ],
      ),
      chainId: _chainId,
    );
    var ticketID = 0;

    final receipt = await _client.getTransactionReceipt(txHash);
    final contractEvent = _contract.event('TicketMinted');
    debugPrint(contractEvent.toString());
    receipt?.logs.forEach((log) {
      var topic = log.topics?[0];
      var signature_bytes = contractEvent.signature;

      if (topic != null && signature_bytes != null) {
        var signature = bytesToHex(signature_bytes);
        debugPrint("Topic: $topic");
        debugPrint("Signature: $signature");
      }
      if (topic.toString() == "0x" + bytesToHex(signature_bytes).toString()) {
        final decoded =
            contractEvent.decodeResults(log.topics ?? [], log.data ?? "");
        final fetchedTicketId =
            decoded[0].toInt(); // Assuming ticketId is the first parameter
        debugPrint("Ticket ID: $fetchedTicketId");
        ticketID = fetchedTicketId;
      }
    });

    return ticketID;
    // print('Minted ticket with ID: $ticketId');
  }

  getOwner(ticketId) async {
    debugPrint("Getting owner of ticket $ticketId...");

    final owner = await _client.call(
      contract: _contract,
      function: _getOwner,
      params: [BigInt.from(ticketId)],
    );

    var ownerAddress;
    if (owner.isNotEmpty) {
      ownerAddress = owner[0] as EthereumAddress;
      print("Received owner address: " + ownerAddress.hex);
    } else {
      print('Could not get owner');
    }

    return ownerAddress.hex;
  }
}
