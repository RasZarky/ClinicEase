// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myccaa/news_feed/provider_classes/home_class.dart';
import 'package:myccaa/news_feed/universal_elements/custom_bg_colors.dart';
import 'package:myccaa/news_feed/universal_elements/links.dart';

import 'home_detailed_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
List<Home>_news=[];
class _HomeScreenState extends State<HomeScreen> {

// Future<dynamic>fetchGeneralNews()async{
//   final response= await http.get(Uri.parse(homeurl));
//
//   if(response.statusCode==200){
//     final data = jsonDecode(response.body);
//     if(mounted){
//       setState(() {
//         _news=List.from(data['data']).map((e) => Home.fromJson(e)).toList();
//       });
//     }
//   }else{
//     throw Exception('error');
//   }
// }

//
// @override
// void initState() {
//    fetchGeneralNews();
//     super.initState();
//   }
//
// Future<void>_refresh()async{
//   await fetchGeneralNews();
//   setState(() {
//
//   });
// }
  Query dbRef = FirebaseDatabase.instance.ref().child('broadcast');

  Widget listItem( {required Map users}){
    return Padding(
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeDetailedScreen(content: users['content'],src: users['image'],title: users['title'],publishedAt: users['date'],author: users['author'],)));
            },
            child: ListTile(
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(tag: users['image'],child: ClipRRect(borderRadius: BorderRadius.circular(30),child: Image.network(users['image'],errorBuilder:(context, error, stackTrace) => const CupertinoActivityIndicator(),)),),
                  ),
                  Text(users['title']),
                ],
              ),
              subtitle: Text(users['description']),
              //leading: Text('test2'),
              // trailing: Text('test3'),
            ),
          ),
        );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
     body: NestedScrollView(
       headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
           title: Text('General News',style: GoogleFonts.albertSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white70)),
           expandedHeight: 210,
           flexibleSpace: FlexibleSpaceBar(
             background: Image.asset('assets/2.png',fit: BoxFit.cover,filterQuality: FilterQuality.high,colorBlendMode: BlendMode.colorBurn),
           ),
           floating: true,
           pinned: true,
           elevation: 0,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         ),
       ],
       body:
       // _news.isEmpty ? const Center(
       //   child: CupertinoActivityIndicator(animating: true,),
       // ):
       SizedBox(
           width: double.infinity,
           child: Container(
             child: FirebaseAnimatedList(
               query: dbRef,
               itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

                 Map users = snapshot.value as Map;
                 users['key'] = snapshot.key;

                 return  listItem(users: users);
               },

             ),
           )
       )
     ),
    );
  }
}
