import 'dart:convert';
import 'dart:io';
import 'package:dcl/Page_Dashboard.dart';
import 'package:dcl/Page_Login.dart';
import 'package:dcl/apiManager/Model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

Future<http.Response> apiLogin(
    BuildContext context, String email, String password) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/login.php');
  final response =
      await ioClient.post(url, body: {"email": email, "password": password});
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  var data = jsonData["data"];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (status == "1") {
    prefs.setString("user_id", data["user_id"]);
    prefs.setString("username", data["user_name"]);
    prefs.setString("email", data["email"]);
    prefs.setString("phone", data["phone"]);

    final databaseRef = FirebaseDatabase.instance.reference();
    FirebaseMessaging.instance.getToken().then((token) {
      databaseRef
          .child("Token")
          .child(data["user_id"].toString())
          .set({'token': token});
      apiToken(context, data["user_id"], token!);
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Page_Dashboard()),
    );
    Toast.show("Login Success...!", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return response;
}

Future<http.Response> apiToken(
    BuildContext context, String user_id, String token_id) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/save_token.php');
  final response = await ioClient
      .post(url, body: {"user_id": user_id, "token_id": token_id});
  var jsonData = json.decode(response.body);
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString("userToken", token_id);
  return response;
}

Future<List<FetchLearnerDetailsList>> apiFetchLearnerDetailsList(
    BuildContext context) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url =
      Uri.parse('https://drivechecklook.co.uk/Api/fetch_learner_details.php');
  final response = await ioClient.get(url);
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  List<FetchLearnerDetailsList> classList = [];
  if (status == "1") {
    var learner_data = jsonData["learner_data"];
    for (var local in learner_data) {
      for (int i = 0; i < 10; i++) {
        FetchLearnerDetailsList classdata = FetchLearnerDetailsList(
          id: local["id"],
          title: local["title"],
          description: local["description"],
          video: local["video"],
          image: local["image"],
        );
        classList.add(classdata);
      }
    }
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return classList;
}

Future<http.StreamedResponse> apiUpdateInfo(
    BuildContext context,
    String user_id,
    File user_profile,
    String user_name,
    String email,
    String phone) async {
  var uri = Uri.parse("https://drivechecklook.co.uk/Api/edit_profile.php");
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  var request = http.MultipartRequest("POST", uri);
  request.fields['user_id'] = user_id.toString();
  request.fields['user_name'] = user_name.toString();
  request.fields['email'] = email.toString();
  request.fields['phone'] = phone.toString();
  if (user_profile.path != "") {
    var profileimg =
        await http.MultipartFile.fromPath("user_profile", user_profile.path);
    request.files.add(profileimg);
  }
  var response = await ioClient.send(request);
  if (response.statusCode == 200) {
    Toast.show(response.statusCode.toString(), context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  } else {
    Toast.show(response.statusCode.toString(), context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return response;
}

Future<List<CategoryList>> apiCategoryList(BuildContext context) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/fetch_tutorial.php');
  final response = await ioClient.get(url);
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  List<CategoryList> classList = [];
  if (status == "1") {
    var fetch_tutoriral = jsonData["fetch_tutoriral"];
    for (var local in fetch_tutoriral) {
      CategoryList classdata = CategoryList(
          tutoriral_id: local["tutoriral_id"],
          tutoriral_name: local["tutoriral_name"],
          tutorialVideo: local["tutorialVideo"]);
      classList.add(classdata);
    }
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return classList;
}

Future<List<TutorialDetailsList>> apiTutorialDetailsList(
    BuildContext context, String tutorail_id) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url =
      Uri.parse('https://drivechecklook.co.uk/Api/fetch_tutorial_details.php');
  final response = await ioClient.post(url, body: {"tutorail_id": tutorail_id});
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  List<TutorialDetailsList> classList = [];
  if (status == "1") {
    var tutorail_details = jsonData["tutorail_details"];
    for (var local in tutorail_details) {
      TutorialDetailsList classdata = TutorialDetailsList(
          id: local["id"],
          title: local["title"],
          description: local["description"],
          video: local["video"],
          tutorail_image: local["tutorail_image"]);
      classList.add(classdata);
    }
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return classList;
}

Future<List<NotificationList>> apiNotificationList(
    BuildContext context, String user_id) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/notification_list.php');
  final response = await ioClient.post(url, body: {"user_id": user_id});
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  List<NotificationList> classList = [];
  if (status == "1") {
    var notification_listing = jsonData["notification_listing"];
    for (var local in notification_listing) {
      NotificationList classdata = NotificationList(
          user_id: local["user_id"],
          user_name: local["user_name"],
          image: local["image"],
          message: local["message"]);
      classList.add(classdata);
    }
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return classList;
}

Future<http.Response> apiContactUs(
    BuildContext context, String user_id, String txtmessage) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/contact_us.php');
  final response = await ioClient
      .post(url, body: {"user_id": user_id, "message": txtmessage});
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  if (status == "1") {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return response;
}

Future<List<FetchTestList>> apiFetchTestList(BuildContext context) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/fetch_test.php');
  final response = await ioClient.get(url);
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  List<FetchTestList> classList = [];
  if (status == "1") {
    var fetch_test = jsonData["fetch_test"];
    for (var local in fetch_test) {
      FetchTestList classdata = FetchTestList(
          testid: local["testid"],
          testType: local["testType"],
          tname: local["tname"],
          description: local["description"],
          video: local["video"],
          test_image: local["test_image"]);
      classList.add(classdata);
    }
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return classList;
}

Future<http.Response> apiForgotPassword(BuildContext context, String phone,
    String password, String country_code) async {
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = await IOClient(httpClient);
  var url = Uri.parse('https://drivechecklook.co.uk/Api/forgot_password.php');
  final response = await ioClient.post(url, body: {
    "phone": phone,
    "password": password,
    "country_code": country_code
  });
  var jsonData = json.decode(response.body);
  var message = jsonData["message"];
  var status = jsonData["status"];
  if (status == "1") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Page_Login()),
    );
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  } else {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return response;
}

Future<http.StreamedResponse> apiUserSignUp(
    BuildContext context,
    File user_profile,
    String user_name,
    String email,
    String country_code,
    String phone,
    String password,
    String confirm_password) async {
  var uri = Uri.parse("https://drivechecklook.co.uk/Api/signup.php");
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = new IOClient(httpClient);
  var request = http.MultipartRequest("POST", uri);
  request.fields['user_name'] = user_name.toString();
  request.fields['country_code'] = country_code.toString();
  request.fields['email'] = email.toString();
  request.fields['phone'] = phone.toString();
  request.fields['password'] = password.toString();
  request.fields['confirm_password'] = confirm_password.toString();

  if (user_profile.path != "") {
    var profileimg =
        await http.MultipartFile.fromPath("user_profile", user_profile.path);
    request.files.add(profileimg);
  }
  var response = await ioClient.send(request);
  if (response.statusCode == 200) {
    Toast.show(response.statusCode.toString(), context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Page_Login()),
    );
  } else {
    Toast.show(response.statusCode.toString(), context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
  return response;
}
