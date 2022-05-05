import 'dart:io';

import 'package:animated_otp_fields/animated_otp_fields.dart';
import 'package:dcl/apiManager/apiManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Page_SignUpOTP extends StatefulWidget {
  File profilePick;
  String usernmae;
  String email;
  String countryCode;
  String phone;
  String password;
  String cpassword;
  Page_SignUpOTP(this.profilePick, this.usernmae, this.countryCode, this.email,
      this.phone, this.password, this.cpassword);
  _Page_SignUpOTPState createState() => _Page_SignUpOTPState(
      profilePick, usernmae, email, countryCode, phone, password, cpassword);
}

class _Page_SignUpOTPState extends State<Page_SignUpOTP> {
  File profilePick;
  String usernmae;
  String email;
  String countryCode;
  String phone;
  String password;
  String cpassword;
  _Page_SignUpOTPState(this.profilePick, this.usernmae, this.countryCode,
      this.email, this.phone, this.password, this.cpassword);
  TextEditingController otptxt = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  late String Verificationcode = "";
  late String VerificationID = "";

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        apiUserSignUp(context, profilePick, usernmae, email, countryCode, phone,
            password, cpassword);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Page_LogIn()));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xffFF4D4E),
          content: Text(e.message.toString())));
    }
  }

  void _otpVerification() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phone,
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            VerificationID = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            Verificationcode = verificationId;
          });
        },
        verificationFailed: (FirebaseAuthException error) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential)
              .then((value) async {
            if (value.user != null) {
              // _trySubmitForm();
            } else {}
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    super.initState();
    _otpVerification();
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
                      SizedBox(height: 30),
                      Text(
                        "Please type the verification code",
                        style:
                            TextStyle(color: Color(0xff7B7B7B), fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "sent to your Mobile No.",
                        style:
                            TextStyle(color: Color(0xff7B7B7B), fontSize: 16),
                      ),
                      SizedBox(height: 30),
                      animated_otp_fields(
                        otptxt,
                        fieldHeight: 45,
                        fieldWidth: 45,
                        autoFocus: false,
                        spaceBetweenFields: 5,
                        OTP_digitsCount: 6,
                        animation: TextAnimation.None,
                        border: Border.all(
                          width: 2,
                          color: Color(0xff152643),
                        ),
                        fieldBackgroungColor: Color(0xff152643),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        forwardCurve: Curves.linearToEaseOut,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Verificationcode = otptxt.text;
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: VerificationID,
                                  smsCode: Verificationcode);
                          signInWithPhoneAuthCredential(phoneAuthCredential);
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
