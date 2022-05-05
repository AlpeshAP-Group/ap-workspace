import 'dart:convert';
import 'dart:io';

import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Sidebar_Contact extends StatefulWidget {
  _Sidebar_ContactState createState() => _Sidebar_ContactState();
}

class _Sidebar_ContactState extends State<Sidebar_Contact> {
  final username = TextEditingController();
  final email = TextEditingController();
  final message = TextEditingController();
  String userId = "";
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

        username.text = user_details["user_name"];
        email.text = user_details["email"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/dashboard_back.png',
                    ),
                    fit: BoxFit.fill)),
            child: Column(children: <Widget>[
              Stack(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 50, left: 20),
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset("assets/backbtn.svg")),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 60, left: 20),
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                )
              ]),
              Expanded(
                  child: Container(
                transform: Matrix4.translationValues(0, 20, 0),
                padding: EdgeInsets.all(15),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    SizedBox(height: 80),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
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
                                enabled: false,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
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
                                enabled: false,
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
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Color(0xffD9E7FF).withOpacity(0.8),
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 30,
                              child: SvgPicture.asset(
                                'assets/messageedit.svg',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: message,
                                enabled: true,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 70),
                    GestureDetector(
                      onTap: () {
                        if (message.text == "") {
                          Toast.show("Please Type Message..!", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          apiContactUs(context, userId, message.text);
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: const BoxDecoration(
                            color: Color(0xff152643),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),
              ))
            ])));
  }
}
