import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myccaa/chat/widgets/favorite_contacts.dart';
import 'package:myccaa/chat/widgets/recent_chats.dart';


class ChatListScreen extends StatefulWidget {
  final AnimationController animationController;

  final String Cid;

  const ChatListScreen({Key? key, required this.animationController, required this.Cid}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState(Cid: Cid);
}

class _ChatListScreenState extends State<ChatListScreen> {

  final String Cid;
  _ChatListScreenState({ required this.Cid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        //leading: IconButton(icon: Icon(Icons.menu,), iconSize: 30.0,color: Colors.white, onPressed: (){}),
        automaticallyImplyLeading: false,
        title: Text("Chats",style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),),
        elevation: 0.0,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search,), iconSize: 30.0,color: Colors.white, onPressed: (){})
        // ],
      ),

      body: Column(
        children: <Widget>[
          //CategorySelector(),
          Expanded(child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  FavoriteContacts(Cid: Cid,),
                  RecentChats(Cid: Cid,),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
