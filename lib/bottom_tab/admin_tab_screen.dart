import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myccaa/main.dart';

import '../chat/doctor_chat_list_screen.dart';
import '../profile/doctor_profile.dart';
import 'components/common_card.dart';
import 'components/tab_button_UI.dart';

class AdminTabScreen extends StatefulWidget {
  final String Id;
  const AdminTabScreen({super.key, required this.Id});

  @override
  State<AdminTabScreen> createState() => _AdminTabScreenState(Id: Id);
}

class _AdminTabScreenState extends State<AdminTabScreen>
    with TickerProviderStateMixin {

  final String Id;
  _AdminTabScreenState({ required this.Id});

  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Database;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startLoadScreen(Id));
    super.initState();
  }

  Future _startLoadScreen(String Id) async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = DatabasePage(Id: Id,);
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: 60 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType)),
        body: _isFirstTime
            ? const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : _indexView,
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      _animationController.reverse().then((f) {
        if (tabType == BottomBarType.Database) {
          setState(() {
            _indexView = DatabasePage(Id: Id,

            );
          });
        } else if (tabType == BottomBarType.Chat) {
          setState(() {
            _indexView = DoctorChatListScreen(
              animationController: _animationController,
              Cid: Id,
            );
          });
        }  else if (tabType == BottomBarType.Reminder) {
          setState(() {
            _indexView = BroadcastPage(
              Id: Id,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            _indexView = DoctorProfileScreen(
              animationController: _animationController,
              Id: Id,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return CommonCard(
      color: Color.fromARGB(255, 209, 232, 243),
      radius: 30,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TabButtonUI(
                icon: Icons.storage,
                isSelected: tabType == BottomBarType.Database,
                text: 'Consultation',
                onTap: () {
                  tabClick(BottomBarType.Database);
                },
              ),
              TabButtonUI(
                icon: Icons.message,
                isSelected: tabType == BottomBarType.Chat,
                text: 'Chat',
                onTap: () {
                  tabClick(BottomBarType.Chat);
                },
              ),
              TabButtonUI(
                icon: Icons.spatial_audio_off,
                isSelected: tabType == BottomBarType.Reminder,
                text: "Broadcast",
                onTap: () {
                  tabClick(BottomBarType.Reminder);
                },
              ),
              TabButtonUI(
                icon: Icons.person,
                isSelected: tabType == BottomBarType.Profile,
                text: 'Profile',
                onTap: () {
                  tabClick(BottomBarType.Profile);
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { Database, Chat, Reminder, Profile }
