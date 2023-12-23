
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myccaa/profile/history_doc.dart';
import 'package:myccaa/profile/widgets/profile_list_item.dart';

import '../main.dart';
import 'activities.dart';
import 'constants.dart';


class DoctorProfileScreen extends StatefulWidget {
   final AnimationController animationController;
   final String Id;

  const DoctorProfileScreen({super.key, required this.animationController, required this.Id});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState(id: Id);
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {

  final String id;
  _DoctorProfileScreenState({required this.id});

  Map? user;

  getdoc() async {
    final snapshot = await FirebaseDatabase.instance.ref().child('doctors').child(id).get();
    setState(() {
      user = snapshot.value as Map;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdoc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/logo.jpg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                        heightFactor: 15,
                      widthFactor: 15,
                      child: Icon(
                        Icons.edit,
                        color: kDarkPrimaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            user == null ? 'name' : user?['first name']+' '+user?['second name'],
            style: kTitleTextStyle,
          ),
          SizedBox(height: 5),
          Text(
            user?['phoneNumber'] ?? 'number',
            style: kCaptionTextStyle,
          ),
          SizedBox(height:  20),
          Container(
            height: 40,
            width:  200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                '',
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );


    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 30),

        profileInfo,
        //themeSwitcher,
        SizedBox(width:30),
      ],
    );


    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height:  50),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Activities(Id: id,)),
                    );
                  },
                  child: const ProfileListItem(
                    icon: Icons.home,
                    text: 'My Activities',
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryDoc(Id: id,)),
                    );
                  },
                  child: ProfileListItem(
                    icon: Icons.history,
                    text: 'Patients History',
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const ProfileListItem(
                    icon: Icons.logout_rounded,
                    text: 'Logout',
                    hasNavigation: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}
