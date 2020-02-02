import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WhatsAppAppBar(),
    );
  }
}

class WhatsAppAppBar extends StatefulWidget {
  @override
  _WhatsAppAppBarState createState() => _WhatsAppAppBarState();
}

class _WhatsAppAppBarState extends State<WhatsAppAppBar>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;
  Color cameraColor = Color(0xB3FFFFFF);

  // method to change the camera opacity to 70% when not pressed
  void changeCameraColor() {
    int index = _tabController.index;
    if (index == 0) {
      cameraColor = Color(0xFFFFFFFF);
    } else {
      cameraColor = Color(0xB3FFFFFF);
    }
    print(cameraColor);
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
    // method to change the camera icon opacity when tab index is changed
    _tabController.addListener(() {
      setState(() {
        changeCameraColor();
      });
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // each of the Tab has both side padding of 16.0 and there are total of
    // 4 of them
    double othersWidth = (deviceWidth - (kCameraButtonWidth + 16 * 8)) / 3;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF075E55),
              title: Text(
                'WhatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 21.0,
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                IconButton(
                  tooltip: 'search',
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  tooltip: 'more',
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3.1,
                isScrollable: true,
                tabs: <Widget>[
                  Container(
                    padding: kHeaderPadding,
                    width: kCameraButtonWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: kCameraIconScale,
                      heightFactor: kCameraIconScale,
                      child: Image(
                        image: AssetImage('images/camera.png'),
                        color: cameraColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: kHeaderPadding,
                    width: othersWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "CHATS",
                      style: kBottomTabTextStyle,
                    ),
                  ),
                  Container(
                    padding: kHeaderPadding,
                    width: othersWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "STATUS",
                      style: kBottomTabTextStyle,
                    ),
                  ),
                  Container(
                    padding: kHeaderPadding,
                    width: othersWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "CALLS",
                      style: kBottomTabTextStyle,
                    ),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Center(child: Text('camera')),
            Center(child: Text('chats')),
            Center(child: Text('status')),
            Center(child: Text('calls')),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00CC3F),
        child: FractionallySizedBox(
          widthFactor: kFABIconScale,
          heightFactor: kFABIconScale,
          child: Image.asset('images/chat.png'),
        ),
      ),
    );
  }
}
