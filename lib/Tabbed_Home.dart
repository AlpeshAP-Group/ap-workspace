import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dcl/Page_DashboardSearch.dart';
import 'package:dcl/Page_Notificaion.dart';
import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Tabbed_Home extends StatefulWidget {
  _Tabbed_HomeState createState() => _Tabbed_HomeState();
}

class _Tabbed_HomeState extends State<Tabbed_Home> {
  String userId = "";
  List<FetchLearnerDetailsList> learnerList = [];

  @override
  void initState() {
    getUserid();
    super.initState();
  }

  getUserid() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    userId = _pref.getString("user_id").toString();
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
  }

  // apiFetchLearnerDetailsList(BuildContext context) async {
  //   HttpClient httpClient = HttpClient()
  //     ..badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => true);
  //   IOClient ioClient = await IOClient(httpClient);
  //   var url =
  //       Uri.parse('https://drivechecklook.co.uk/Api/fetch_learner_details.php');
  //   final response = await ioClient.get(url);
  //   var jsonData = json.decode(response.body);
  //   var message = jsonData["message"];
  //   var status = jsonData["status"];
  //   if (status == "1") {
  //     var learner_data = jsonData["learner_data"];
  //     for (var local in learner_data) {
  //       setState(() {
  //         FetchLearnerDetailsList classdata = FetchLearnerDetailsList(
  //           id: local["id"],
  //           title: local["title"],
  //           description: local["description"],
  //           video: local["video"],
  //           image: local["image"],
  //         );
  //         learnerList.add(classdata);
  //       });
  //     }
  //   } else {
  //     Toast.show(message, context,
  //         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Stack(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height > 1000 ? 500 : 420,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/dashboard_back.png',
                      ),
                      fit: BoxFit.fill)),
              child: Image.asset(
                'assets/dashboard_back.png',
              )),
          Column(children: <Widget>[
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
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Welcome back",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Paul!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Page_DashboardSearch()),
                  );
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Search for New Tutorials!",
                            style: TextStyle(
                                color: Color(0xff272727), fontSize: 16),
                          ),
                          Icon(Icons.search)
                        ]))),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                color: Color(0xffD9E7FF),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            "Start learning",
                            style: TextStyle(
                                color: Color(0xff272727),
                                fontSize: MediaQuery.of(context).size.width >
                                        1000
                                    ? MediaQuery.of(context).size.width / 30
                                    : MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            "Driving!",
                            style: TextStyle(
                                color: Color(0xff272727),
                                fontSize: MediaQuery.of(context).size.width >
                                        1000
                                    ? MediaQuery.of(context).size.width / 30
                                    : MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: const BoxDecoration(
                              color: Color(0xff152643),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Categories',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    1000
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  SvgPicture.asset("assets/outarrow.svg")
                                ]))
                      ]),
                  Container(
                      transform: Matrix4.translationValues(20, 0, 0),
                      // width: MediaQuery.of(context).size.width / 2.5,
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset("assets/sleep_guy.svg",
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width / 2.2)),
                ],
              ),
            ),
          ]),
        ]),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Text(
            'Learn New Things',
            style: TextStyle(
                color: Color(0xff272727),
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
        ),
        // Expanded(
        //     child: Center(
        //   child: Text("Data Not Found...!"),
        // ))

        // Expanded(
        //     child: Container(
        //         alignment: Alignment.topLeft,
        //         margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        //         child: FutureBuilder<List<FetchLearnerDetailsList>>(
        //           future: apiFetchLearnerDetailsList(context),
        //           builder: (context, snapshot) {
        //             if (snapshot.hasData) {
        //               List<FetchLearnerDetailsList>? data = snapshot.data;
        //               return ListView.builder(
        //                   shrinkWrap: true,
        //                   itemCount: data?.length,
        //                   scrollDirection: Axis.horizontal,
        //                   itemBuilder: (BuildContext context, int index) {
        //                     return Container(
        //                         padding: EdgeInsets.all(15),
        //                         margin: EdgeInsets.only(left: 10),
        //                         width: 300,
        //                         decoration: BoxDecoration(
        //                             color: Colors.white,
        //                             borderRadius:
        //                                 BorderRadius.all(Radius.circular(30)),
        //                             boxShadow: [
        //                               BoxShadow(
        //                                   color: Colors.grey.withOpacity(0.1),
        //                                   spreadRadius: 5,
        //                                   blurRadius: 7,
        //                                   offset: Offset(0, 3))
        //                             ]),
        //                         child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: <Widget>[
        //                               Container(
        //                                 height: 150,
        //                                 decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.all(
        //                                         Radius.circular(20)),
        //                                     image: data![index].image != ""
        //                                         ? DecorationImage(
        //                                             image: NetworkImage(
        //                                                 data[index].image),
        //                                             fit: BoxFit.fill)
        //                                         : DecorationImage(
        //                                             image: AssetImage(
        //                                                 "assets/Logo.png"),
        //                                             fit: BoxFit.fill)),
        //                                 // child: data![index].image != ""
        //                                 //     ? Image.network(data[index].image)
        //                                 //     : Image.asset("assets/Logo.png"),
        //                               ),
        //                               Text(
        //                                 data[index].title,
        //                                 style: TextStyle(
        //                                     color: Colors.black,
        //                                     fontSize: 22,
        //                                     fontWeight: FontWeight.w700),
        //                               ),
        //                               SizedBox(height: 5),
        //                               Text(
        //                                 data[index].description,
        //                                 style: TextStyle(
        //                                     color: Color(0xff7B7B7B),
        //                                     fontSize: 16),
        //                               ),
        //                               Container(
        //                                   alignment: Alignment.bottomRight,
        //                                   child: SvgPicture.asset(
        //                                     "assets/carinarrow.svg",
        //                                   ))
        //                             ]));
        //                   });
        //             } else if (snapshot.hasError) {
        //               return Text("${snapshot.error}");
        //             }
        //             return Center(
        //               child: Text("Data Not Found...!"),
        //             );
        //           },
        //         )))
      ]),
    );
  }
}
