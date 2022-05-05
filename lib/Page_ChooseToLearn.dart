import 'dart:convert';
import 'dart:io';

import 'package:dcl/Page_Notificaion.dart';
import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/io_client.dart';
import 'package:toast/toast.dart';

class Page_ChooseToLearn extends StatefulWidget {
  String tutorail_id;
  Page_ChooseToLearn(this.tutorail_id);
  _Page_ChooseToLearnState createState() =>
      _Page_ChooseToLearnState(tutorail_id);
}

class _Page_ChooseToLearnState extends State<Page_ChooseToLearn> {
  String tutorail_id;
  _Page_ChooseToLearnState(this.tutorail_id);
  // List<TutorialDetailsList> detailsList = [];

  @override
  void initState() {
    super.initState();
  }

  // getTutorialDetails() async {
  //   HttpClient httpClient = HttpClient()
  //     ..badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => true);
  //   IOClient ioClient = await IOClient(httpClient);
  //   var url = Uri.parse(
  //       'https://drivechecklook.co.uk/Api/fetch_tutorial_details.php');
  //   final response =
  //       await ioClient.post(url, body: {"tutorail_id": tutorail_id});
  //   var jsonData = json.decode(response.body);
  //   var message = jsonData["message"];
  //   var status = jsonData["status"];
  //   if (status == "1") {
  //     var tutorail_details = jsonData["tutorail_details"];
  //     for (var local in tutorail_details) {
  //       setState(() {
  //         TutorialDetailsList classdata = TutorialDetailsList(
  //             id: local["id"],
  //             title: local["title"],
  //             description: local["description"],
  //             video: local["video"],
  //             tutorail_image: local["tutorail_image"]);
  //         detailsList.add(classdata);
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
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 50, left: 20),
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        "assets/backbtn.svg",
                        height: 48,
                        width: 48,
                      ))),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Choose What",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "to Learn",
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
                padding: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xffF2F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: FutureBuilder<List<TutorialDetailsList>>(
                  future: apiTutorialDetailsList(context, tutorail_id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<TutorialDetailsList>? data = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data![index].title,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    data[index].description,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Color(0xff272727), fontSize: 16),
                                  )
                                ]);
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: Text("Data Not Found...!"),
                    );
                  },
                ),
              ))
            ])));
  }
}
