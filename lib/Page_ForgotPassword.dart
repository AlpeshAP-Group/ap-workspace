import 'package:country_code_picker/country_code_picker.dart';
import 'package:dcl/Page_ForgotPhoneVerification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class Page_ForgotPassword extends StatefulWidget {
  _Page_ForgotPasswordState createState() => _Page_ForgotPasswordState();
}

class _Page_ForgotPasswordState extends State<Page_ForgotPassword> {
  String countryCode = "";
  final mobile = TextEditingController();

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
                    "Forgot Password",
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
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      SvgPicture.asset(
                        "assets/forgotimg.svg",
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Please enter your registered Phone no.",
                        style:
                            TextStyle(color: Color(0xff7B7B7B), fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
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
                                            hintText: '1234567890',
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
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          if (countryCode == "") {
                            Toast.show(
                                "Please Select Country Code...!", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          } else if (mobile.text == "") {
                            Toast.show("Enter Mobile Number...!", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Page_ForgotPhoneVerification(countryCode,mobile.text)),
                            );
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
                            child: Text(
                              'Send',
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
