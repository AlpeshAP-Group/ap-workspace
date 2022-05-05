import 'dart:convert';
import 'dart:io';

import 'package:dcl/Page_UserProgress.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabbed_Profile extends StatefulWidget {
  _Tabbed_ProfileState createState() => _Tabbed_ProfileState();
}

class _Tabbed_ProfileState extends State<Tabbed_Profile> {
  final username = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  bool isUsername = false;
  bool ismobile = false;
  bool isEmail = false;
  String userId = "";
  String profileImg = "";

  String userProfile = "";
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
        userId = _prefs.getString("user_id").toString();
        profileImg = user_details["user_profile"];
        username.text = user_details["user_name"];
        mobile.text = user_details["mobile_number"];
        email.text = user_details["email"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/dashboard_back.png',
                    ),
                    fit: BoxFit.fill)),
            child: Column(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60),
                  alignment: Alignment.topCenter,
                  child: Text(
                    isUsername ? "Edit Profile" : "My Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Visibility(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isUsername = !isUsername;
                          ismobile = !ismobile;
                          isEmail = !isEmail;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 50, right: 20),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            "assets/editprofile.svg",
                            height: 48,
                            width: 48,
                          ))), //"assets/saveright.svg"
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isUsername ? false : true,
                ),
                Visibility(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isUsername = !isUsername;
                          ismobile = !ismobile;
                          isEmail = !isEmail;
                        });
                        apiUpdateInfo(context, userId, File(userProfile),
                            username.text, email.text, mobile.text);
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 50, right: 20),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            "assets/saveright.svg",
                            height: 48,
                            width: 48,
                          ))), //"assets/saveright.svg"
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isUsername ? true : false,
                )
              ]),
              SizedBox(height: 20),
              Expanded(
                  child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Color(0xffF2F7FF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3, color: Color(0xff152643)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                            ),
                            child: Container(
                              height: 110,
                              width: 110,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  image: profileImg == ""
                                      ? userProfile != ""
                                          ? DecorationImage(
                                              image: FileImage(
                                              File(userProfile),
                                            ))
                                          : DecorationImage(
                                              image: AssetImage(
                                                  "assets/userprofilepic.png"),
                                              fit: BoxFit.fitWidth,
                                            )
                                      : DecorationImage(
                                          image: NetworkImage(profileImg),
                                          fit: BoxFit.fitWidth,
                                        )),
                            ),
                          ),
                          //   Container(
                          // padding: EdgeInsets.all(5),
                          // height: 120,
                          // width: 120,
                          // decoration: BoxDecoration(
                          //   border:
                          //       Border.all(width: 3, color: Color(0xff152643)),
                          //   borderRadius: BorderRadius.all(Radius.circular(60)),
                          // ),
                          // child: Container(
                          //     height: 110,
                          //     width: 110,
                          //     decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(60)),
                          //         image: userProfile != ""
                          //             ? DecorationImage(
                          // image: FileImage(
                          //   File(userProfile),
                          // ),
                          //                 fit: BoxFit.fitWidth)
                          // : DecorationImage(
                          //     image: AssetImage(
                          //         "assets/userprofilepic.png"),
                          //     fit: BoxFit.fitWidth,
                          //   )),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          Visibility(
                            child: GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff152643),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Stack(children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'My Insights',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                            "assets/outarrow.svg",
                                            height: 15))
                                  ])),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Page_UserProgress(userId)),
                                );
                              },
                            ),
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isUsername ? false : true,
                          ),
                          Visibility(
                            child: GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width / 3,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff152643),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Text(
                                    'Change Photo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                              onTap: () async {
                                try {
                                  final imagePicker = ImagePicker();
                                  final pickedFile = await imagePicker.getImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (pickedFile != null) {
                                    setState(() {
                                      userProfile = pickedFile.path;
                                    });
                                  }
                                } on Exception catch (ex) {
                                  print(ex);
                                }
                              },
                            ),
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isUsername ? true : false,
                          ),
                          SizedBox(height: 30),
                          Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                color: isUsername
                                    ? Colors.white
                                    : Color(0xffD9E7FF).withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    child: SvgPicture.asset(
                                      'assets/usericon.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: username,
                                      keyboardType: TextInputType.text,
                                      enabled: isUsername,
                                      style: TextStyle(color: Colors.black87),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: ismobile
                                  ? Colors.white
                                  : Color(0xffD9E7FF).withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  child: SvgPicture.asset(
                                    'assets/call.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: mobile,
                                    enabled: ismobile,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Phone No.',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                color: isEmail
                                    ? Colors.white
                                    : Color(0xffD9E7FF).withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    child: SvgPicture.asset(
                                      'assets/email.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: email,
                                      enabled: isEmail,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'E-mail',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ]),
                      )))
            ])));
  }
}
