import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dcl/Page_Login.dart';
import 'package:dcl/Sidebar_About.dart';
import 'package:dcl/Sidebar_Contact.dart';
import 'package:dcl/Sidebar_FAQs.dart';
import 'package:dcl/Sidebar_Privacy.dart';
import 'package:dcl/Sidebar_Tearms.dart';
import 'package:dcl/Tabbed_Home.dart';
import 'package:dcl/Tabbed_Profile.dart';
import 'package:dcl/Tabbed_Test.dart';
import 'package:dcl/Tabbed_Tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Page_Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Page_DashboardState();
  }
}

class Page_DashboardState extends State<Page_Dashboard>
    with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  int navIndex = 0;
  String Address = "";

  List _screens = [];
  @override
  void initState() {
    _screens.add(Tabbed_Home());
    _screens.add(Tabbed_Tutorial());
    _screens.add(Tabbed_Test());
    _screens.add(Tabbed_Profile());

    setString();
    super.initState();
  }

  setString() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString("isLogin", "true");
      setState(() {
        Address = _prefs.getString("currentplace").toString();
      });
    } catch (e) {
      print(e);
    }
  }

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  );
  EdgeInsets padding = const EdgeInsets.all(12);
  Color selectedColor = Color(0xff152643);
  Color unselectedColor = Colors.black;
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _currentIndex = i;
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(child: Center(child: _screens.elementAt(_currentIndex))),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(top: 50, left: 20),
                child: SvgPicture.asset(
                  "assets/menu.svg",
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: BottomNavigationBar(
            backgroundColor: Color(0xff152643),
            selectedItemColor: Color(0xff7697CF),
            unselectedItemColor: Color(0xffFFFFFF),
            currentIndex: _currentIndex,
            onTap: _handleIndexChanged,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Color(0xff152643),
                icon: SvgPicture.asset("assets/bottom_home.svg"),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xff152643),
                icon: SvgPicture.asset("assets/bottom_tutorial.svg"),
                label: 'Tutorial',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xff152643),
                icon: SvgPicture.asset("assets/bottom_test.svg"),
                label: 'Test',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xff152643),
                icon: SvgPicture.asset("assets/bottom_profile.svg"),
                label: 'Profile',
              ),
            ],
          ),
        ),
        extendBody: true,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff152643),
          ),
          child: Sidenav(navIndex, (int index) {
            setState(() {
              navIndex = index;
            });
          }),
        ));
  }
}

class Sidenav extends StatefulWidget {
  final Function setIndex;
  final int selectedIndex;
  Sidenav(this.selectedIndex, this.setIndex);
  @override
  State<StatefulWidget> createState() {
    return SidenavState(selectedIndex, setIndex);
  }
}

// ignore: must_be_immutable
class SidenavState extends State<Sidenav> {
  final Function setIndex;
  final int selectedIndex;
  SidenavState(this.selectedIndex, this.setIndex);
  bool isAppoinment = false;
  bool isPromocode = false;
  bool isSetting = false;
  bool isSupport = false;
  String profileImg = "";
  String name = "";
  String email = "";

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  _getProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(httpClient);
    var url = Uri.parse('https://drivechecklook.co.uk/Api/fetch_profile.php');
    final response = await ioClient
        .post(url, body: {"user_id": _prefs.getString("user_id").toString()});
    var jsonData = json.decode(response.body);
    var status = jsonData["status"];
    if (status == "1") {
      var user_details = jsonData["user_details"];
      setState(() {
        profileImg = user_details["user_profile"];
        name = user_details["user_name"];
        email = user_details["email"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
          decoration: BoxDecoration(),
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    image: profileImg != ""
                        ? DecorationImage(
                            image: NetworkImage(profileImg),
                            fit: BoxFit.fitWidth)
                        : DecorationImage(
                            image: AssetImage("assets/userprofilepic.png"),
                            fit: BoxFit.fill)),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  name == "" ? "Your Name" : name,
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                child: Text(
                  email == "" ? "email@gmail.com" : email,
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          )),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () async {},
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 30),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_home.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Home',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sidebar_About()),
                      );
                    },
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_about.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sidebar_Privacy()),
                      );
                    },
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_privacy.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Privacy & Policy',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sidebar_Tearms()),
                      );
                    },
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_terms.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Tearms & Condition',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sidebar_FAQs()),
                      );
                    },
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_FAQ.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'FAQs',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sidebar_Contact()),
                      );
                    },
                    child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              child: SvgPicture.asset(
                                "assets/sidebar_contact.svg",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
              ]),
        ),
      ),
      GestureDetector(
          onTap: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 16,
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Are you sure you want to logout?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () async {
                                    SharedPreferences _prefs =
                                        await SharedPreferences.getInstance();
                                    _prefs.setString("isLogin", "false");
                                    Toast.show(
                                        "Logout Successfully...!", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page_Login()),
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xff152643),
                                      border: Border.all(
                                          color: Colors
                                              .white12, // Set border color
                                          width: 1.0), // Set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              30.0)), // Set rounded corner radius
                                    ),
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xff152643),
                                      border: Border.all(
                                          color: Colors
                                              .white12, // Set border color
                                          width: 1.0), // Set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              30.0)), // Set rounded corner radius
                                    ),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
              height: 40,
              margin: EdgeInsets.only(left: 15, bottom: 20),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    child: SvgPicture.asset(
                      "assets/sidebar_logout.svg",
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ))),
    ]));
  }
}

enum _SelectedTab { home, favorite, search, person }
