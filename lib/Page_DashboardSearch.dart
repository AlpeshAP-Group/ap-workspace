import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Page_DashboardSearch extends StatefulWidget {
  _Page_DashboardSearchState createState() => _Page_DashboardSearchState();
}

class _Page_DashboardSearchState extends State<Page_DashboardSearch> {
  TextEditingController controller = TextEditingController();
  List<SearchDetails> _searchResult = [];
  List<SearchDetails> _userDetails = [];
  List<bool> selectbool = [];
  //Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    var url = Uri.parse('https://drivechecklook.co.uk/Api/search.php');
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/users');

    var response = await http.post(url);
    var responseJson = json.decode(response.body);
    var message = responseJson["message"];
    var status = responseJson["status"];
    var data = responseJson["search_details"];

    setState(() {
      for (Map<String, dynamic> user in data) {
        _userDetails.add(SearchDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    _searchResult.clear();
    _userDetails.clear();
    selectbool.clear();
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F7FF),
      body: Container(
          child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.only(top: 50, left: 20),
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset("assets/backcolored.svg")),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff7697CF).withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                    hintText: 'Search for new Tutorials!',
                                    border: InputBorder.none),
                                onChanged: onSearchTextChanged,
                              ),
                              onTap: () {
                                controller.clear();
                                onSearchTextChanged('');
                              }),
                        ),
                        Icon(Icons.search)
                      ])),
            ),
          ]),
          Container(
            child: Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              // height: 150,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: Colors.grey.shade200,
                                      offset: Offset(0, 1))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: 90,
                                              width: 90,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          _searchResult[index]
                                                              .image),
                                                      fit: BoxFit.fill))),
                                          SizedBox(width: 5),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                _searchResult[index].title,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                          SvgPicture.asset(
                                              "assets/cardplaybtn.svg")
                                        ]),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Text(
                                          _searchResult[index].description,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff7B7B7B)),
                                        )),
                                  ]),
                            ));
                      },
                    )
                  : ListView.builder(
                      itemCount: _userDetails.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                              // height: 150,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: Colors.grey.shade200,
                                      offset: Offset(0, 1))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: 90,
                                              width: 90,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          _userDetails[index]
                                                              .image),
                                                      fit: BoxFit.fill))),
                                          SizedBox(width: 5),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                _userDetails[index].title,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                          SvgPicture.asset(
                                            "assets/cardplaybtn.svg",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                          )
                                        ]),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Text(
                                          _userDetails[index].description,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff7B7B7B)),
                                        )),
                                  ]),
                            ));
                      },
                    ),
            ),
          )
        ],
      )),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _userDetails.forEach((userDetail) {
      if (userDetail.title.contains(text) ||
          userDetail.description.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

class SearchDetails {
  final String id;
  final String title;
  final String description;
  final String video;
  final String image;

  SearchDetails(
      {required this.id,
      required this.title,
      required this.description,
      required this.video,
      required this.image});

  factory SearchDetails.fromJson(Map<String, dynamic> json) {
    return SearchDetails(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      video: json['video'],
      image: json['image'],
    );
  }
}
