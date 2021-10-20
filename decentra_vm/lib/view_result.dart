import 'package:decentra_vm/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
class ViewResult extends StatelessWidget {
  const ViewResult({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var candidateList = Provider.of<VotingMachineModel>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Results "),

      ),
      body: Container(
        padding: EdgeInsets.only(left:10.0,right:10.0),
        child: Column(
          children: List.generate(candidateList.candidateCount, (index){return Container(
            child: ListTile(
              title : Text(candidateList.candidates[index].candidateName + " - " + candidateList.candidates[index].partyName + "-"+candidateList.candidates[index].voteCount.toString()),
              subtitle: FAProgressBar(currentValue: candidateList.candidates[index].voteCount.toInt() * 10,
              animatedDuration: Duration(seconds: 2),
              size: 20,
              )
            )
          );}
          ),
        ),
      ),
    );
  }
}