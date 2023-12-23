
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myccaa/profile/widgets/profile_list_item.dart';
import 'package:myccaa/profile/history.dart';
import '../main.dart';
import 'constants.dart';

class ProfileScreen extends StatefulWidget {
   final AnimationController animationController;
   final String id;
  const ProfileScreen({super.key, required this.animationController, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(id: id);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String id;
  _ProfileScreenState({required this.id});

  Map? user;

  getdoc() async {
    final snapshot = await FirebaseDatabase.instance.ref().child('patients').child(id).get();
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
            user?['phoneNumber'] ?? 'numbur',
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
                          builder: (context) => History(Id: id,)),
                    );
                  },
                  child: ProfileListItem(
                    icon: Icons.history,
                    text: 'Medical History',
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
                  child: ProfileListItem(
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
