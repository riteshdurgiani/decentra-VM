import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
class VotingMachineModel extends ChangeNotifier{
  List<Candidate> candidates = [];
  int candidateCount = 0;
  bool isLoading = true;
  bool isCandidateAdded = false;
  final String _rpcUrl = "http://192.168.0.108:7545";
  final String _wsUrl = "ws://192.168.0.108:7545/";

  final String _privateKey = "eb56580675412b3f561e6589820c3fed26c78a851e03aa9d72c57519b550e899";
  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late Credentials _credentials;

  late ContractFunction _candidateCount;
  late ContractFunction _totalVotes;
  late ContractFunction _candidates;
  late ContractFunction _addCandidate;
  late ContractEvent _CandidateAdded;
  late ContractFunction _casteVote;
  late ContractEvent _VoteCasted;
  
  VotingMachineModel(){
    initiateSetup();
    //getAbi();
  }

  Future<void>initiateSetup()async {
      _client = Web3Client(_rpcUrl, Client(),socketConnector: (){
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      });

      await getAbi();
      await getCredentials();
      await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/VotingMachine.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);


    
    print(_contractAddress);
  }

  Future<void> getCredentials() async {
     _credentials = await _client.credentialsFromPrivateKey(_privateKey);
     _ownAddress = await _credentials.extractAddress();

  }

  Future<void> getDeployedContract() async{
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "VotingMachine"),_contractAddress);

    _candidateCount = _contract.function("candidateCount");
    _totalVotes = _contract.function("totalVotes");
    _candidates = _contract.function("candidates");
    _addCandidate = _contract.function("addCandidate");
    _casteVote = _contract.function("casteVote");

    _CandidateAdded = _contract.event("CandidateAdded");
    _VoteCasted = _contract.event("VoteCasted");

    getCandidates();

    //calling functions
   
    
  }

  getCandidates() async{
    List totalCandidatesList = await _client.call(contract: _contract, function: _candidateCount, params: []);
    BigInt totalCandidates = totalCandidatesList[0];
    candidateCount = totalCandidates.toInt();
    candidates.clear();
    print(candidateCount);
    for(var i=0;i<totalCandidates.toInt();i++){
      var candidate = await _client.call(contract: _contract, function: _candidates, params: [BigInt.from(i)]);
      candidates.add(Candidate(candidateName: candidate[0], partyName: candidate[1], isWinner: candidate[3], voteCount: candidate[2].toInt()));
      
    }
    

    isLoading = false;
    notifyListeners();
  }

  addCandidate(String candidateNameData,String partyNameData)async{
    await _client.sendTransaction(_credentials, 
    Transaction.callContract(
    contract: _contract, 
    function: _addCandidate, 
    parameters: [candidateNameData,partyNameData]));

    isCandidateAdded = true;
    notifyListeners();
  }

  casteVote(BigInt candidateId,String candidateNameData,String partyNameData)async {
    await _client.sendTransaction(_credentials,
     Transaction.callContract(
       contract: _contract, 
       function: _casteVote, 
       parameters: [candidateId,candidateNameData,partyNameData]));
       
  }




}
class Candidate{
  String candidateName;
  String partyName;
  bool isWinner;
  int voteCount;

  Candidate({required this.candidateName,required this.partyName,required this.isWinner,required this.voteCount});
}