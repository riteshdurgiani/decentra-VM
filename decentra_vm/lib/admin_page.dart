
import 'package:decentra_vm/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
 
  
  @override
  Widget build(BuildContext context) {
    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();
    var candidateList = Provider.of<VotingMachineModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: Text("Candidate Name : "),flex: 2),
              Expanded(
                flex: 3,
                child: TextField(controller: t1),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(child: Text("Party Name : "),flex: 2),
              Expanded(
                flex: 3,
                child: TextField(controller: t2,),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  child: Text("Add Candidate"),
                  onPressed: (){
                    candidateList.addCandidate(t1.text, t2.text);
                  },
                ),
              )
            ],
          ),
        )
      ],),
    );
  }
}