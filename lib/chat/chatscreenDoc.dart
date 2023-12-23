import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'models/message_model.dart';
import 'models/user_model.dart';

class ChatScreenDoc extends StatefulWidget {
  ChatScreenDoc({required this.user, required this.Cid,});
  Map user;
  String Cid;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatScreenDocState(user: user, Cid: Cid,);
  }
}

class _ChatScreenDocState extends State<ChatScreenDoc> {
  final Map user;
  final String Cid;
  _ChatScreenDocState( {required this.user, required this.Cid});
  final TextEditingController _messageTextEditingController = TextEditingController();

  Widget listItem( {required Map pending}){
    bool isMe = pending['receiver'] == Cid;

    return _buildMessages(pending, isMe);
      // ListView.builder(
      //   reverse: true,
      //   itemCount: messages.length,
      //   itemBuilder: (contx, index) {
      //     Message message = messages[index];
      //     bool isMe = message.sender.id == currentUser.id;
      //     return _buildMessages(message, isMe);
      //   });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Query dbRef1 = FirebaseDatabase.instance.ref().child('doctors').child(Cid).child('messages').child(user['phoneNumber']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          user['first name']+" "+user['second name'],
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.more_horiz,), iconSize: 30.0,color: Colors.white, onPressed: (){})
        // ],
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Expanded(
        child: Container(
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30))),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 100,
              child: FirebaseAnimatedList(
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
            ),
          ),
        ),
      ),
    ),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  _buildMessages(Map message, isMe) {
    msg() {
      return Container(
        width: MediaQuery.of(context).size.width * .75,
        decoration: BoxDecoration(
            color: isMe ? Color(0XFFF7F9F9) : Color(0XFFFFEFEE),
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
        margin: isMe
            ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80)
            : EdgeInsets.only(top: 8.0, bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message['time'].substring(0,message['time'].indexOf('.')),
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              message['message'],
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      );
    }

    if (isMe) {
      return msg();
    }
    return Row(
      children: <Widget>[
        msg(),
        //message.isLiked? IconButton(icon: Icon(Icons.favorite),color:Theme.of(context).primaryColor, onPressed: (){}):IconButton(icon: Icon(Icons.favorite_border,color: Colors.blueGrey,), onPressed: (){})
      ],
    );
  }

  _buildComposer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey, width: 1)),
      height: 70,
      child: Row(
        children: <Widget>[
          //IconButton(icon: Icon(Icons.camera_alt,color:Theme.of(context).primaryColor,size: 35,), onPressed: null),
           Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: _messageTextEditingController,
                decoration:
                    const InputDecoration.collapsed(hintText: "Write your message"),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send,
                  color: Theme.of(context).primaryColor, size: 35),
              onPressed: (){
                if(_messageTextEditingController.text.isNotEmpty){

                  final databaseRef = FirebaseDatabase.instance.ref().child('doctors').child(Cid);
                  final databaseRef2 = FirebaseDatabase.instance.ref().child('patients').child(Cid);

                  String message = _messageTextEditingController.text.trim();
                  DateTime date = DateTime.now();

                  if(databaseRef != null){

                    FirebaseDatabase.instance.ref().child('doctors').child(Cid).child("messages").child(user['phoneNumber'])
                        .child(user['phoneNumber']+date.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
                      'sender': Cid,
                      'receiver': user['phoneNumber'],
                      'time': date.toString(),
                      'message': message,

                    });

                    FirebaseDatabase.instance.ref().child('patients').child(user['phoneNumber']).child("messages").child(Cid)
                        .child(Cid+date.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
                      'sender': Cid,
                      'receiver': user['phoneNumber'],
                      'time': date.toString(),
                      'message': message,

                    });

                    FirebaseDatabase.instance.ref().child('patients').child(user['phoneNumber']).child("recent").child(Cid)
                        .set({
                      'sender': Cid,
                      'receiver': user['phoneNumber'],
                      'time': date.toString(),
                      'message': message,
                      'unread': 'yes',

                    });

                    FirebaseDatabase.instance.ref().child('doctors').child(Cid).child("recent").child(user['phoneNumber'])
                        .set({
                      'sender': Cid,
                      'receiver': user['phoneNumber'],
                      'time': date.toString(),
                      'message': message,
                      'unread': 'yes',

                    });

                    FirebaseDatabase.instance.ref().child('doctors').child(Cid).child('peers').child(user['phoneNumber']).set({
                      'peer': user['phoneNumber'],
                    });

                    FirebaseDatabase.instance.ref().child('patients').child(user['phoneNumber']).child('peers').child(Cid).set({
                      'peer': Cid,
                    });
                  }
                //   else if(databaseRef2 != null){
                // //
                // //     FirebaseDatabase.instance.ref().child('patients').child(user['Id']).child("messages").child(Cid)
                // //         .child(user['Id']+date.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
                // //       'sender': Cid,
                // //       'receiver': user['Id'],
                // //       'time': date.toString(),
                // //       'message': message,
                // //       'unread': 'yes',
                // //
                // //     });
                // //
                // //     FirebaseDatabase.instance.ref().child('doctors').child(Cid).child("messages").child(user['Id'])
                // //         .child(Cid+date.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '')).set({
                // //       'sender': Cid,
                // //       'receiver': user['Id'],
                // //       'time': date.toString(),
                // //       'message': message,
                // //       'unread': 'yes',
                // //
                // //     });
                // //
                // //     FirebaseDatabase.instance.ref().child('patients').child(Cid).child("recent").child(user['Id'])
                // //     .set({
                // // 'sender': Cid,
                // // 'receiver': user['Id'],
                // // 'time': date.toString(),
                // // 'message': message,
                // // 'unread': 'yes',
                // //
                // // });
                // //
                // //     FirebaseDatabase.instance.ref().child('doctors').child(user['Id']).child("recent").child(Cid)
                // //     .set({
                // // 'sender': Cid,
                // // 'receiver': user['Id'],
                // // 'time': date.toString(),
                // // 'message': message,
                // // 'unread': 'yes',
                // //
                // // });
                // //
                // //     FirebaseDatabase.instance.ref().child('patients').child(user['Id']).child('peers').child(Cid).set({
                // //       'peer': Cid,
                // //     });
                // //
                // //     FirebaseDatabase.instance.ref().child('doctors').child(Cid).child('peers').child(user['Id']).set({
                // //       'peer': user['Id'],
                // //     });
                //
                //   }
                  else{

                    var snackBar = const SnackBar(
                      content: Text( "User not found",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }

                  setState(() {
                    _messageTextEditingController.clear();
                  });
                }
              }),
        ],
      ),
    );
  }
}
