import 'package:flutter/material.dart';
import 'package:myccaa/chat/chat_list_screen.dart';
import 'package:myccaa/main.dart';

import '../news_feed/home.dart';
import '../profile/profile.dart';
import 'components/common_card.dart';
import 'components/tab_button_UI.dart';


class BottomTabScreen extends StatefulWidget {
  @override

  final String Id;
  const BottomTabScreen({super.key, required this.Id});

  _BottomTabScreenState createState() => _BottomTabScreenState(Id: Id);
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {

  final String Id;
  _BottomTabScreenState({ required this.Id});

  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.Latest;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _indexView = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = const HomeScreen();
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
        if (tabType == BottomBarType.Latest) {
          setState(() {
            _indexView = HomeScreen(

            );
          });
        } else if (tabType == BottomBarType.Chat) {
          setState(() {
            _indexView = ChatListScreen(
              animationController: _animationController, Cid: Id,
            );
          });
        }  else if (tabType == BottomBarType.Reminder) {
          setState(() {
            _indexView = ReminderPage(

            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            _indexView = ProfileScreen(
              animationController: _animationController,
              id: Id,
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
                icon: Icons.search,
                isSelected: tabType == BottomBarType.Latest,
                text: 'Latest',
                onTap: () {
                  tabClick(BottomBarType.Latest);
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
                icon: Icons.timer,
                isSelected: tabType == BottomBarType.Reminder,
                text: "Reminder",
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

enum BottomBarType { Latest, Chat, Reminder, Profile }
