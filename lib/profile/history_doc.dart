import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:myccaa/profile/history_detail.dart';

class HistoryDoc extends StatefulWidget {
  final String Id;
  const HistoryDoc({super.key, required this.Id});

  @override
  State<HistoryDoc> createState() => _HistoryDocState(Id: Id);
}

class _HistoryDocState extends State<HistoryDoc> {

  final String Id;
  _HistoryDocState({ required this.Id});

  Widget listItem( {required Map pending}){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryDetails(history: pending,)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),

        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pending['patient name'],
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Text(
              pending['patient Id'],
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Text(
              pending['date'],
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    // AlertDialog(
                    //     title: const Center(
                    //       child: Column(
                    //         children: [
                    //           Icon(Icons.warning_outlined,
                    //               size: 36, color: Colors.red),
                    //           SizedBox(height: 20),
                    //           Text("Confirm order update"),
                    //         ],
                    //       ),
                    //     ),
                    //     content: Container(
                    //       //color: secondaryColor,
                    //       height: 110,
                    //       child: Column(
                    //         children: [
                    //           Text(
                    //               "Are you sure want to process '${pending['orderId']}'?"),
                    //           SizedBox(
                    //             height: 16,
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               ElevatedButton.icon(
                    //                   icon: Icon(
                    //                     Icons.close,
                    //                     size: 14,
                    //                   ),
                    //                   style: ElevatedButton.styleFrom(
                    //                       primary: Colors.grey),
                    //                   onPressed: () {
                    //                     Navigator.of(context).pop();
                    //                   },
                    //                   label: Text("Cancel")),
                    //               SizedBox(
                    //                 width: 20,
                    //               ),
                    //               ElevatedButton.icon(
                    //                   icon: Icon(
                    //                     Icons.delete,
                    //                     size: 14,
                    //                   ),
                    //                   style: ElevatedButton.styleFrom(
                    //                       primary: Colors.red),
                    //                   onPressed: () {},
                    //                   label: Text("Cancel order"))
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ));
                    FirebaseDatabase.instance.ref().child('records').child(pending['key']).remove();
                    var snackBar = const SnackBar(
                      content: Text( "Broadcast deleted",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25,
                        backgroundColor: Colors.red),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Query dbRef1 = FirebaseDatabase.instance.ref().child('records').orderByChild('doctor id').equalTo(Id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis history'),
      ),
      body: FirebaseAnimatedList(
        query: dbRef1,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

          Map pending = snapshot.value as Map;
          pending['key'] = snapshot.key;

          return  listItem(pending: pending);
        },

      ),
    );
  }
}
