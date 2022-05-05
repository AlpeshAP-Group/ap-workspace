import 'package:country_code_picker/country_code_picker.dart';
import 'package:dcl/Page_ForgotPassword.dart';
import 'package:dcl/Page_SignUp.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Page_Login extends StatefulWidget {
  @override
  _Page_LoginState createState() => _Page_LoginState();
}

class _Page_LoginState extends State<Page_Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool _validate = false;
  bool passwordVisible = false;
  bool isRemember = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _savedData();
    super.initState();
  }

  Future<void> _savedData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("isLogin", "false");
  }

  alertBox(bool boolVal, String txtValue) {
    if (boolVal == true && txtValue == "email") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Email Field Can\'t be Empty!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (boolVal == true && txtValue == "password") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Password Field Can\'t be Empty!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // final appleSignInAvailable =
    //     Provider.of<AppleSignInAvailable>(context, listen: false);
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
            Container(
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/Logo.svg")),
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        transform: Matrix4.translationValues(0, 30, 0),
                        alignment: Alignment.topLeft,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Color(0xffF2F7FF),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(1, 3))
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Color(0xff152643),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 30),
                            Column(children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    color: Color(0xff7697CF).withOpacity(0.2),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topRight: Radius.circular(15)),
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
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style:
                                              TextStyle(color: Colors.black87),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'E-mail',
                                              hintStyle: TextStyle(
                                                color: Colors.black38,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xff7697CF).withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                      child: SvgPicture.asset(
                                        'assets/password.svg',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        obscureText: true,
                                        controller: password,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Colors.black87),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            // contentPadding: EdgeInsets.all(0),
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                              color: Colors.black38,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Page_ForgotPassword()),
                                  );
                                },
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Forgot Password?",
                                      style:
                                          TextStyle(color: Color(0xff272727)),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (email.text.isEmpty == true) {
                                    alertBox(_validate = true, "email");
                                  } else if (password.text.isEmpty == true) {
                                    alertBox(_validate = true, "password");
                                  } else {
                                    apiLogin(
                                        context, email.text, password.text);
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff152643),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Login',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 10),
                                          SvgPicture.asset(
                                              "assets/outarrow.svg")
                                        ])),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page_SignUp()),
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Don't have an account?",
                                              style: TextStyle(
                                                  color: Color(0xff272727),
                                                  fontSize: 18),
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color: Color(0xff272727),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18),
                                            )),
                                      ]),
                                ),
                              )
                            ]),
                          ]),
                        ))))
          ])),
    );
  }
}
