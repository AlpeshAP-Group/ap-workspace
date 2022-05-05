import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff152643),
      body: Center(
          child: SvgPicture.asset(
        'assets/Logo.svg',
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 6,
      )),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.locationAlways,
        Permission.locationWhenInUse,
        Permission.storage,
        Permission.camera,
      ].request();
    });
  }
}
