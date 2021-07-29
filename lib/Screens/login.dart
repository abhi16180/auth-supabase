import 'dart:async';

import 'package:auth/AuthenticationManger/authmanager.dart/authmanager.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:progressive_image/progressive_image.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _key = GlobalKey<FormState>();
  bool signedup = false;
  bool _obscure = true;
  AuthManger _authManger = new AuthManger();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Future<void> loginUser(String email, String password) async {
      final resp = await _authManger.logInWithExistingAccount(email, password);
      var box = Get.find<GetStorage>();
      box.write('loggedIn', true);
      if (resp.data != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error',
              style: TextStyle(fontFamily: 'Questrial'),
            ),
            backgroundColor: Colors.amberAccent,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 240,
                    height: 240,
                    child: ProgressiveImage(
                      width: 240,
                      height: 240,
                      thumbnail: AssetImage('assets/images/astro.png'),
                      placeholder: AssetImage('assets/images/earth.png'),
                      image: AssetImage('assets/images/astro.png'),
                    ),
                  ),
                ),
                Form(
                  key: _key,
                  child: Container(
                    width: width < 720 ? 300 : 380,
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurpleAccent,
                                Colors.lightBlue
                              ],
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Email is required'),
                              EmailValidator(errorText: 'Type correct Email')
                            ]),
                            controller: _emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hoverColor: Colors.cyan.withAlpha(160),
                              filled: true,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              errorStyle:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        //Password

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurpleAccent,
                                Colors.lightBlue
                              ],
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: TextFormField(
                            obscureText: _obscure,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Password is required'),
                              MinLengthValidator(6,
                                  errorText: 'Minimum length is 6'),
                              MaxLengthValidator(24,
                                  errorText: 'Max length is 24'),
                            ]),
                            controller: _passwordController,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscure = !_obscure;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              hoverColor: Colors.cyan.withAlpha(160),
                              filled: true,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withAlpha(200)),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              errorStyle:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 28,
                        ),

                        //Retype password

                        signedup == false
                            ? MaterialButton(
                                hoverColor: Colors.red.withAlpha(200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                color: Colors.pinkAccent,
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    setState(() {
                                      signedup = !signedup;
                                    });
                                    Timer(
                                      Duration(seconds: 2),
                                      () {
                                        loginUser(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      '  Sign-up  ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                child: Lottie.network(
                                  'https://assets6.lottiefiles.com/packages/lf20_3ye4yhzj.json',
                                  width: 200,
                                  height: 40,
                                ),
                              ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
