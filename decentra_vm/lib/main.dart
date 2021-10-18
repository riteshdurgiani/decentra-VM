import 'package:decentra_vm/candidate_list.dart';
import 'package:decentra_vm/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VotingMachineModel(),
      child: MaterialApp(
        title: 'Decentra-VM',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home: CandidateList(),
      ),
    );
  }
}

