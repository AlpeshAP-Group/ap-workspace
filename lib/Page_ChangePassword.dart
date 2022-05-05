import 'package:animated_otp_fields/animated_otp_fields.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Page_ChangePassword extends StatefulWidget {
  String countryCode;
  String mobile;
  Page_ChangePassword(this.countryCode, this.mobile);
  _Page_ChangePasswordState createState() => _Page_ChangePasswordState(countryCode,mobile);
}

class _Page_ChangePasswordState extends State<Page_ChangePassword> {
  String countryCode;
  String mobile;
  _Page_ChangePasswordState(this.countryCode, this.mobile);
  final newpassword = TextEditingController();
  final confirmnewpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  alertBox(bool boolVal, String txtValue) {
    if (boolVal == true && txtValue == "password") {
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
    } else if (boolVal == true && txtValue == "cpassword") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Confirm Passwrord Field Can\'t be Empty!'),
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
                    "Phone Verification",
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
                padding: EdgeInsets.all(30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF2F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Please Enter New Password",
                        style:
                            TextStyle(color: Color(0xff7B7B7B), fontSize: 16),
                      ),
                      SizedBox(height: 30),
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
                                controller: newpassword,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // contentPadding: EdgeInsets.all(0),
                                    hintText: 'Enter New Password',
                                    hintStyle: TextStyle(
                                      color: Colors.black38,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
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
                                controller: confirmnewpassword,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black87),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // contentPadding: EdgeInsets.all(0),
                                    hintText: 'Enter Confirm New Password',
                                    hintStyle: TextStyle(
                                      color: Colors.black38,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (newpassword.text.isEmpty == true) {
                            alertBox(true, "password");
                          } else if (confirmnewpassword.text.isEmpty == true) {
                            alertBox(true, "cpassword");
                          } else if (newpassword.text !=
                              confirmnewpassword.text) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Warning'),
                                content: const Text('Password Doesn\'t Match!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            apiForgotPassword(context,mobile,newpassword.text,countryCode);
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Page_ChangePassword()),
                          // );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: const BoxDecoration(
                              color: Color(0xff152643),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ]),
              ))
            ])));
  }
}
