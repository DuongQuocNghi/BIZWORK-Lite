
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatViewHomeTab.dart';
import 'CheckInViewHomeTab.dart';
import 'TaskViewHomeTab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent swipe popping of this page. Use explicit exit buttons only.
      onWillPop: () => Future<bool>.value(true),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.conversation_bubble),
                title: Text('Chat'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bookmark),
                title: Text('Task'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.time),
                title: Text('Check In'),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 2);
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) => ChatViewHomeTab(),
                  defaultTitle: 'Chat',
                );
                break;
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) => TaskViewHomeTab(),
                  defaultTitle: 'Task',
                );
                break;
              case 2:
                return CupertinoTabView(
                  builder: (BuildContext context) => CheckInViewHomeTab(),
                  defaultTitle: 'Check In',
                );
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}



