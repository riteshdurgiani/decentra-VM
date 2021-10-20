import 'package:decentra_vm/admin_page.dart';
import 'package:decentra_vm/candidate_list.dart';
import 'package:decentra_vm/candidate_model.dart';
import 'package:decentra_vm/view_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
            child: Card(
              child: Image(image: AssetImage('src/images/Ballot.jpg'),width: 500,height: 1,),
              shadowColor: Colors.white,
              
            ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPage()));
                  }, child: Text("Admin")),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(
              children: [
                Expanded(
                  
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CandidateList()));
                  }, child: Text("Voter")),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewResult()));
                  }, child: Text("Results")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget callAdmin(){
    return AdminPage();
  }
  Widget callCandList(){
    return CandidateList();
  }

  
}