import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDetails extends StatefulWidget {
  final Map history;
  const HistoryDetails({super.key, required this.history});

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState(history: history);
}

class _HistoryDetailsState extends State<HistoryDetails> {

  final Map history;
  _HistoryDetailsState({ required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(history['patient name']+' - '+history['date']),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(
                history['patient name'],
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 5,),
              Text(
                history['patient Id'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 5,),
              Text(
                history['date'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Weight',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['weight']+' kg',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Temperature',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['temperature'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Blood pressure',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['bp'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Complain',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['complain'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Remarks',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['remarks'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Prescription',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 2,),
              Text(
                history['prescribe'],
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),

              const SizedBox(height: 30,),
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
                      FirebaseDatabase.instance.ref().child('records').child(history['key']).remove();
                      var snackBar = const SnackBar(
                        content: Text( "Record deleted",
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
      ),
    );
  }
}
