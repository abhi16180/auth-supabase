import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

import 'Screens/home.dart';
import 'Screens/register.dart';

final supabaseUrl = '<supabase url>';
final supabaseKey = '<supabase key>';
GetStorage box = new GetStorage();

void main() async {
  await GetStorage.init();
  Get.put<SupabaseClient>(SupabaseClient(supabaseUrl, supabaseKey));
  Get.put<GetStorage>(GetStorage());
  runApp(MaterialApp(
    theme: ThemeData(
      shadowColor: Colors.red,
      hintColor: Colors.white,
      fontFamily: 'Questrial',
    ),
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      if (box.read('loggedIN') == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(Colors.cyan),
          semanticsLabel: 'loading screen',
        ),
      ),
    );
  }
}
