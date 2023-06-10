import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.68.61:7545";
  final String _wsUrl = "ws://192.168.68.61:7545/";
  final String _privateKey =
      "0x81dd0d1c1e65628c83e8ea3637bbea5b2d0e987246bb02e2b02d7d4ffec20ffc";

  late Web3Client _client;
  late bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;

  late String deployedName;

  ContractLinking() {
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
    debugPrint('ABI done!');
    getCredentials();
    debugPrint('Credentials done!');
    await getDeployedContract();
    debugPrint('Deployed contract done!');
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

  void getCredentials() async {
    // _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");
    debugPrint('Will get name...');
    print(_yourName);
    print(_setName);
    await getName();
  }

  getName() async {
    // Getting the current name declared in the smart contract.
    var currentName = await _client
        .call(contract: _contract, function: _yourName, params: []);
    deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  setName(String nameToSet) async {
    // Setting the name to nameToSet(name defined by user)
    debugPrint('Setting name...');
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _setName,
            parameters: <dynamic>[nameToSet]),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);
    await getName();
  }
}
