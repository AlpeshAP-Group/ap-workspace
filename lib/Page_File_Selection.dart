import 'package:dcl/Page_Dashboard.dart';
import 'package:dcl/Page_Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page_File_Selection extends StatefulWidget {
  _Page_File_SelectionState createState() => _Page_File_SelectionState();
}

class _Page_File_SelectionState extends State<Page_File_Selection> {
  late String? isLogin = "";

  @override
  void initState() {
    _getThingsOnStartup().then((value) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      isLogin = _prefs.getString("isLogin");
      if (isLogin == "false" || isLogin == null || isLogin == "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Page_Login()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Page_Dashboard()),
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Page_Dashboard("normal", "", "", "", "", "", "")),
        // );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
