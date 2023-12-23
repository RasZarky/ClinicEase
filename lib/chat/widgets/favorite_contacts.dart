
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../chatscreen.dart';
import '../models/message_model.dart';


class FavoriteContacts extends StatelessWidget{

  final String Cid;
  const FavoriteContacts({super.key, required this.Cid});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Query dbRef1 = FirebaseDatabase.instance.ref().child('doctors');

    Widget listItem( {required Map pending}){
        return GestureDetector(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_){
            return ChatScreen(user: pending, Cid: Cid,);
          }));
          },
          child: Padding(padding: EdgeInsets.all(8),
            child:
            Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                    backgroundImage: AssetImage("assets/logo.jpg"),
                ),
                SizedBox(height: 6.0,),
                Text('Dr. '+pending['first name'],style: TextStyle(color:Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 14.0),)
              ],
            ),),
        );
    }

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      child: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Doctors' Contacts",style: TextStyle(color: Colors.blueGrey,fontSize: 16.0,fontWeight: FontWeight.bold),),
                //IconButton(icon: Icon(Icons.more_horiz),color: Colors.blueGrey, onPressed: (){

               // })
              ],
            ),
          ),
          Container(
            height: 100,
            child: FirebaseAnimatedList(
              scrollDirection: Axis.horizontal,
              query: dbRef1,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                Map pending = snapshot.value as Map;
                pending['key'] = snapshot.key;

                return  listItem(pending: pending);
              },

            ),
            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //     itemCount: favorite.length,
            //     itemBuilder: (BuildContext context,int index){
            //   return GestureDetector(
            //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_){
            //       return ChatScreen(user:favorite[index]);
            //     }));
            //     },
            //     child: Padding(padding: EdgeInsets.all(8),
            //       child:
            //       Column(
            //         children: <Widget>[
            //           CircleAvatar(
            //             radius: 30,
            //               backgroundImage: AssetImage(favorite[index].imageUrl),
            //           ),
            //           SizedBox(height: 6.0,),
            //           Text(favorite[index].name,style: TextStyle(color:Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 14.0),)
            //         ],
            //       ),),
            //   );
            // }),
          )
        ],
      ),
    );
  }

}