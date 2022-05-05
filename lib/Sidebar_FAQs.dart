import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Sidebar_FAQs extends StatefulWidget {
  _Sidebar_FAQsState createState() => _Sidebar_FAQsState();
}

class _Sidebar_FAQsState extends State<Sidebar_FAQs> {
  List<UserDetails> _userDetails = [];

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  Future<Null> getUserDetails() async {
    var url = Uri.parse('https://drivechecklook.co.uk/Api/faq.php');

    var response = await http.post(url);
    var responseJson = json.decode(response.body);
    var message = responseJson["message"];
    var status = responseJson["status"];
    var data = responseJson["faq_list"];

    setState(() {
      for (Map<String, dynamic> user in data) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
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
                    "FAQs",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                )
              ]),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                          transform: Matrix4.translationValues(0, 20, 0),
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Color(0xffF2F7FF),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Frequently asked questions",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xff272727),
                                          fontSize: 18),
                                    )),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: _userDetails.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _userDetails[index].ischecked =
                                                _userDetails[index].ischecked
                                                    ? false
                                                    : true;
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    color: Colors.black26,
                                                    offset: Offset(0, 1))
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                            ),
                                            child: Column(children: <Widget>[
                                              ListTile(
                                                title: Text(_userDetails[index]
                                                    .question),
                                                trailing: SvgPicture.asset(
                                                    _userDetails[index]
                                                            .ischecked
                                                        ? "assets/arrow_down.svg"
                                                        : "assets/arrow_up.svg"),
                                              ),
                                              Visibility(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Text(
                                                    _userDetails[index].answer,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7B7B7B)),
                                                  ),
                                                ),
                                                maintainSize: false,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                visible: _userDetails[index]
                                                        .ischecked
                                                    ? true
                                                    : false,
                                              ),
                                            ])));
                                  },
                                )),
                              ]))))
            ])));
  }
}

class UserDetails {
  final String question;
  final String answer;
  bool ischecked = false;

  UserDetails(
      {required this.question, required this.answer, required this.ischecked});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      question: json['question'],
      answer: json['answer'],
      ischecked: false,
    );
  }
}
