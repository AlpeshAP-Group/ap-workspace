import 'dart:convert';
import 'dart:io';

import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/io_client.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:toast/toast.dart';

class Page_UserProgress extends StatefulWidget {
  String userId;
  Page_UserProgress(this.userId);
  _Page_UserProgressState createState() => _Page_UserProgressState(userId);
}

class _Page_UserProgressState extends State<Page_UserProgress> {
  String userId;
  _Page_UserProgressState(this.userId);
  List<UserProgressList> graphData = [];

  @override
  void initState() {
    getUserGraph();
    super.initState();
  }

  getUserGraph() async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = await IOClient(httpClient);
    var url = Uri.parse('https://drivechecklook.co.uk/Api/graph.php');
    final response = await ioClient.post(url, body: {"user_id": "35"});
    var jsonData = json.decode(response.body);
    var message = jsonData["message"];
    var status = jsonData["status"];
    if (status == "1") {
      var data = jsonData["data"];
      for (var local in data) {
        setState(() {
          UserProgressList classdata = UserProgressList(
            id: local["id"],
            year: local["year"],
            rate: local["rate"],
          );
          graphData.add(classdata);
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
                    "Progress Over Time",
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
                decoration: BoxDecoration(
                  color: Color(0xffF2F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        "Average Score of 4.0 out of 5",
                        style: TextStyle(
                            color: Color(0xff152643),
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        width: MediaQuery.of(context).size.width / 1.2,
                        lineHeight: 30.0,
                        barRadius: Radius.circular(10),
                        percent: 0.8,
                        progressColor: Color(0xff152643),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.height / 2.5,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F7FF),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                                color: Colors.grey.shade700.withOpacity(0.2))
                          ]),
                      child: charts.TimeSeriesChart(
                        _createSampleData(),
                        animate: false,
                      ),
                    )
                  ]),
                ),
              ))
            ])));
  }

  List<charts.Series<UserProgressList, DateTime>> _createSampleData() {
    final data = graphData;

    return [
      new charts.Series<UserProgressList, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (UserProgressList sales, _) =>
            DateTime(int.parse(sales.year)),
        measureFn: (UserProgressList sales, _) => int.parse(sales.rate),
        data: data,
      )
    ];
  }
}
