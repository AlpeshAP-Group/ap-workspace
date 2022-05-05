import 'package:dcl/Page_ChooseToLearn.dart';
import 'package:dcl/Page_Notificaion.dart';
import 'package:dcl/apiManager/Model.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabbed_Tutorial extends StatefulWidget {
  _Tabbed_TutorialState createState() => _Tabbed_TutorialState();
}

class _Tabbed_TutorialState extends State<Tabbed_Tutorial> {
  String userId = "";
  @override
  void initState() {
    getUserid();
    super.initState();
  }

  getUserid() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    userId = _pref.getString("user_id").toString();
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
                  "Choose the",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Category",
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
                child: FutureBuilder<List<CategoryList>>(
                  future: apiCategoryList(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CategoryList>? data = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Page_ChooseToLearn(
                                                data![index].tutoriral_id)),
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 30,
                                        bottom: 30),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff7697CF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3))
                                        ]),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            data![index].tutoriral_name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset("assets/rightarrow.svg",
                                          height: 20)
                                    ])));
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
