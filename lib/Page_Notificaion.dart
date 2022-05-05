import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Page_Notification extends StatefulWidget {
  String userId;
  Page_Notification(this.userId);
  _Page_NotificationState createState() => _Page_NotificationState(userId);
}

class _Page_NotificationState extends State<Page_Notification> {
  String userId;
  _Page_NotificationState(this.userId);

  @override
  void initState() {
    super.initState();
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
                    "Notification",
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
                    child: FutureBuilder<List<NotificationList>>(
                  future: apiNotificationList(context, userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<NotificationList>? data = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      height: 80,
                                      width: 80,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Color(0xff152643)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(60)),
                                      ),
                                      child: data![index].image != ""
                                          ? Image.network(data[index].image,
                                              height: 70, width: 70)
                                          : Image.asset(
                                              "assets/userprofile.png",
                                              height: 70,
                                              width: 70),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          data[index].message,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(height: 5),
                                  Divider(
                                      color:
                                          Color(0xff152643).withOpacity(0.08),
                                      height: 1,
                                      thickness: 1)
                                ]));
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: Text("Data Not Found...!"),
                    );
                  },
                )),
              ))
            ])));
  }
}
