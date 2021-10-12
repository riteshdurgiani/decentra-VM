import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';


class VotingMachineModel extends ChangeNotifier{
  List<Candidate> candidates = [];
  final String _rpcUrl = "http://192.168.0.108:7545";
  final String _wsUrl = "ws://192.168.0.108:7545/";

  final String _privateKey = "eb56580675412b3f561e6589820c3fed26c78a851e03aa9d72c57519b550e899";
  late Web3Client _client;
  VotingMachineModel(){
    initiateSetup();
    getAbi();
  }

  initiateSetup()async {
      _client = Web3Client(_rpcUrl, Client(),socketConnector: (){
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      });
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/VotingMachine.json");
    print(abiStringFile);
  }
}
class Candidate{
  String candidateName;
  String partyName;
  bool isWinner;
  int voteCount;

  Candidate({required this.candidateName,required this.partyName,required this.isWinner,required this.voteCount});
}