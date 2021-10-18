

import 'package:decentra_vm/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidateList extends StatelessWidget {
  const CandidateList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var candidateList = Provider.of<VotingMachineModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidates "),
      ),
      body: candidateList.isLoading 
      ? Center(
        child: CircularProgressIndicator(),
      )
      :Column(
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: candidateList.candidateCount,
              itemBuilder: (context,index)=>ListTile(
                tileColor: Colors.white24,
                hoverColor: Colors.lightBlue,
                contentPadding: EdgeInsets.all(10.0),
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text(candidateList.candidates[index].candidateName),
                subtitle: Text(candidateList.candidates[index].partyName),
                trailing:ElevatedButton(
                child: Text("Vote"),
                onPressed: (){},
                ),
              )
            ),
          )
        ],
      )
    );
  }
}
