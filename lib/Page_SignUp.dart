import 'dart:io';
import 'package:animated_otp_fields/animated_otp_fields.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dcl/Page_Login.dart';
import 'package:dcl/Page_SignupOTP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Page_SignUp extends StatefulWidget {
  _Page_SignUpState createState() => _Page_SignUpState();
}

class _Page_SignUpState extends State<Page_SignUp> {
  String countryCode = "";
  String userProfile = "";
  PickedFile? pickedFile = null;
  final username = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  alertBox(bool boolVal, String txtValue) {
    if (boolVal == true && txtValue == "username") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Username Field Can\'t be Empty!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (boolVal == true && txtValue == "mobile") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Phone Field Can\'t be Empty!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (boolVal == true && txtValue == "country") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Please Select Country Code...!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (boolVal == true && txtValue == "email") {
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
    } else if (boolVal == true && txtValue == "cpassword") {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Confirm Password Field Can\'t be Empty!'),
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
                    "Registration",
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
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 3, color: Color(0xff152643)),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                              image: userProfile != ""
                                  ? DecorationImage(
                                      image: FileImage(
                                        File(userProfile),
                                      ),
                                      fit: BoxFit.fitWidth)
                                  : DecorationImage(
                                      image: AssetImage(
                                          "assets/userprofilepic.png"),
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width / 3,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff152643),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Change Photo',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                        onTap: () async {
                          try {
                            final imagePicker = ImagePicker();
                            final pickedFile = await imagePicker.getImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                userProfile = pickedFile.path;
                              });
                            }
                          } on Exception catch (ex) {
                            print(ex);
                          }
                        },
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
                                  'assets/usericon.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: username,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                      )),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff7697CF).withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            child: CountryCodePicker(
                              onChanged: (e) =>
                                  {countryCode = e.dialCode.toString()},
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'IN',
                              favorite: ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
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
                                      'assets/call.svg',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: mobile,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: Colors.black87),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone No.',
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black87),
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
                      SizedBox(height: 10),
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
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                      )),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 10),
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
                                  controller: cpassword,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Re-enter Password',
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                      )),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          bool emailValid = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(email.text);
                          if (username.text.isEmpty == true) {
                            alertBox(true, "username");
                          } else if (countryCode == "") {
                            alertBox(true, "country");
                          } else if (mobile.text.isEmpty == true) {
                            alertBox(true, "mobile");
                          } else if (email.text.isEmpty == true) {
                            alertBox(true, "email");
                          } else if (!emailValid) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Warning'),
                                content: const Text('Email ID not Valid!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else if (password.text.isEmpty == true) {
                            alertBox(true, "password");
                          } else if (cpassword.text.isEmpty == true) {
                            alertBox(true, "cpassword");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Page_SignUpOTP(
                                        File(userProfile),
                                        username.text,
                                        email.text,
                                        countryCode,
                                        mobile.text,
                                        password.text,
                                        cpassword.text)));
                          }
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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Sign up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  SvgPicture.asset("assets/outarrow.svg")
                                ])),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Page_Login()),
                            );
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                          color: Color(0xff272727),
                                          fontSize: 18),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Color(0xff272727),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    )),
                              ]),
                        ),
                      )
                    ]),
              ))
            ])));
  }
}
