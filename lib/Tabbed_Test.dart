import 'dart:convert';
import 'dart:io';

import 'package:dcl/Page_Notificaion.dart';
import 'package:dcl/Page_TakeVideoTest.dart';
import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Tabbed_Test extends StatefulWidget {
  _Tabbed_TestState createState() => _Tabbed_TestState();
}

class _Tabbed_TestState extends State<Tabbed_Test> {
  List<FetchTestList> testList = [];

  String userId = "";
  @override
  void initState() {
    getUserid();
    super.initState();
  }

  getUserid() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = await IOClient(httpClient);
    var url = Uri.parse('https://drivechecklook.co.uk/Api/fetch_test.php');
    final response = await ioClient.get(url);
    var jsonData = json.decode(response.body);
    var message = jsonData["message"];
    var status = jsonData["status"];
    if (status == "1") {
      var fetch_test = jsonData["fetch_test"];
      for (var local in fetch_test) {
        setState(() {
          userId = _pref.getString("user_id").toString();
          FetchTestList classdata = FetchTestList(
              testid: local["testid"],
              testType: local["testType"],
              tname: local["tname"],
              description: local["description"],
              video: local["video"],
              test_image: local["test_image"]);
          testList.add(classdata);
        });
      }
    } else {
      Toast.show(message, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Page_Notification(userId)),
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 50, right: 20),
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        "assets/notificationbell.svg",
                        height: 48,
                        width: 48,
                      ))),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Give Your",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Practical Test",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
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
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    (MediaQuery.of(context).size.height > 1000)
                                        ? 4
                                        : 2,
                                mainAxisExtent:
                                    (MediaQuery.of(context).size.height / 5),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: testList.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) =>
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Page_TakeVideoTest(
                                                      testList[index].video)),
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      image: testList[index]
                                                                  .test_image ==
                                                              "https://drivechecklook.co.uk/Admin/upload/test/"
                                                          ? DecorationImage(
                                                              image: NetworkImage(
                                                                  testList[index]
                                                                      .test_image),
                                                              fit: BoxFit.fill)
                                                          : DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/thumbnail.png"),
                                                              fit:
                                                                  BoxFit.fill))),
                                              SvgPicture.asset(
                                                  "assets/cardplaybtn.svg")
                                            ],
                                          )))))))
            ])));
  }
}
