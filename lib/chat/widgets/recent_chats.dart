import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../chatscreen.dart';
import '../models/message_model.dart';


class RecentChats extends StatefulWidget{

  final String Cid;
  const RecentChats({super.key, required this.Cid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecentChatsState(Cid: Cid);
  }

}

class _RecentChatsState extends State<RecentChats>{

  final String Cid;
  _RecentChatsState({ required this.Cid});


  late  Map peer;

  // @override
  // Future<void> initState() async {
  //
  // final snapshot = await FirebaseDatabase.instance.ref().child('patients').child(Cid).child('peers').get();
  //
  // setState(() {
  //   peer = snapshot.value as Map;
  // });
  //
  //   super.initState();
  // }

   first()  {
  //   final snapshot = await databaseRef.get();
  //   Map key = snapshot.value as Map;
  //   key['key'] = snapshot.key;
  //   if(key['key'].startsWith(Cid)){
  //     setState(() {
  //       id = key['key'];
  //       dbRef1 = FirebaseDatabase.instance.ref().child('messages').child(id);
  //     });
  //   }else{
  //     dbRef1 = FirebaseDatabase.instance.ref().child('messages').child('0501324976doc12345');
  //   }
   }

  Widget listItem( {required Map pending}){
    return Expanded(
      child: GestureDetector(
        onTap: () async {

          // if(pending['sender'] != Cid){
          //   var snackBar = SnackBar(
          //     content: Text( pending['sender'],
          //       textAlign: TextAlign.center,
          //       style: TextStyle(fontSize: 15),
          //     ),
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // }else{
          //   var snackBar = SnackBar(
          //     content: Text( pending['receiver'],
          //       textAlign: TextAlign.center,
          //       style: TextStyle(fontSize: 15),
          //     ),
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // }

        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            child: GestureDetector(
                onTap: () async {
                  if(pending['sender'] != Cid){
                      final snapshot = await FirebaseDatabase.instance.ref().child('doctors').child(pending['sender']).get();
                      Map user = snapshot.value as Map;

                      // var snackBar = SnackBar(
                      //   content: Text( user['first name']+' '+user['second name']+Cid,
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(fontSize: 15),
                      //   ),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return ChatScreen(user: user, Cid: Cid,);
                      }));

                  }else{
                    final snapshot = await FirebaseDatabase.instance.ref().child('doctors').child(pending['receiver']).get();
                    Map user = snapshot.value as Map;

                    // var snackBar = SnackBar(
                    //   content: Text( user['first name']+' ..'+user['second name']+Cid,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return ChatScreen(user: user, Cid: Cid,);
                    }));

                  }

                },
                child: Container(
                  margin: EdgeInsets.only(top: 5.0,right: 20.0,bottom: 5.0),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                    color: pending['unread'] == 'yes'?Color(0XFFFFEFEE):Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(radius: 30,backgroundImage: AssetImage('assets/log.jpg'),),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(pending['sender'],style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
                              SizedBox(height: 10,),
                              Container(width:MediaQuery.of(context).size.width*.45,
                                  child: Text(pending['message'],
                                    style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600,color: Colors.blueGrey),
                                  overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(pending['time'].substring(0,pending['time'].indexOf('.')),style: TextStyle(color: Colors.grey,fontSize: 8.0), overflow: TextOverflow.ellipsis ,),
                          SizedBox(height: 5.0,),
                          pending['unread'] == 'yes'?Container(width:40,height:20,alignment:Alignment.center,decoration:BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(30))),child: Text('New',style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)):Text(''),
                        ],
                      )
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     

    Query dbRef1 = FirebaseDatabase.instance.ref().child('patients').child(Cid).child('recent');
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      child: FirebaseAnimatedList(
        query: dbRef1,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

          Map pending = snapshot.value as Map;
          pending['key'] = snapshot.key;

          return  listItem(pending: pending);
        },

      ),
    );
    //   Expanded(
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
    //     ),
    //     child: ClipRRect(
    //         borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
    //       child: ListView.builder(
    //           itemCount: chats.length,
    //
    //           itemBuilder: (context,index){
    //         Message chat=chats[index];
    //         return GestureDetector(
    //           //ToDo re implement
    //           // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_){
    //           //   return ChatScreen(user:chat.sender);
    //           // }));
    //           //},
    //           child: Container(
    //             margin: EdgeInsets.only(top: 5.0,right: 20.0,bottom: 5.0),
    //             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
    //               color: chat.unread?Color(0XFFFFEFEE):Colors.white
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Row(
    //                   children: <Widget>[
    //                     CircleAvatar(radius: 30,backgroundImage: AssetImage(chat.sender.imageUrl),),
    //                     SizedBox(width: 10,),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(chat.sender.name,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.grey),),
    //                         SizedBox(height: 10,),
    //                         Container(width:MediaQuery.of(context).size.width*.45,
    //                             child: Text(chat.text,
    //                               style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w600,color: Colors.blueGrey),
    //                             overflow: TextOverflow.ellipsis,
    //                             )),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //                 Column(
    //                   children: <Widget>[
    //                     Text(chat.time,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15.0),),
    //                     SizedBox(height: 5.0,),
    //                     chat.unread?Container(width:40,height:20,alignment:Alignment.center,decoration:BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.all(Radius.circular(30))),child: Text('New',style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),)):Text(''),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         );
    //       }),
    //     ),
    //   ),
    // );
  }

}