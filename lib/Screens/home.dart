import 'package:auth/AuthenticationManger/authmanager.dart/authmanager.dart';
import 'package:auth/Screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

bool switchValue = false;
AuthManger _authManger = new AuthManger();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            await _authManger.logOut();
            var box = Get.find<GetStorage>();
            box.remove('loggedIN');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterPage();
                },
              ),
            );
          },
          child: Text('Log-out'),
          color: Colors.cyan,
        ),
      ),
    );
  }
}
