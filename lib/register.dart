import 'dart:async';
import 'package:auth/AuthenticationManger/authmanager.dart/authmanager.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './Screens/home.dart';

import 'package:progressive_image/progressive_image.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  AuthManger _authmanager = new AuthManger();
  final _key = GlobalKey<FormState>();
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool signedup = false;

    Future<void> registerUser(
        String name, String email, String password) async {
      final response = await _authmanager.createUserWithEmailAndPassword(
          name, email, password);
      if (response.data != null) {
        var box = Get.find<GetStorage>();
        box.write('loggedIN', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home();
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error')));
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
                        //name

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
                            validator: RequiredValidator(
                              errorText: 'Name is required',
                            ),
                            controller: _nameController,
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
                                borderSide: BorderSide(
                                    color: Colors.white.withAlpha(0)),
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
                              labelText: 'Name',
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
                        //Email

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
                            validator: (value) => MatchValidator(
                                    errorText: 'Passwords do not match')
                                .validateMatch(
                                    value!, _passwordController.text),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hoverColor: Colors.cyan.withAlpha(160),
                              filled: true,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Retype password',
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
                        signedup == false
                            ? MaterialButton(
                                hoverColor: Colors.red.withAlpha(200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                color: Colors.pinkAccent,
                                onPressed: () async {
                                  setState(() {
                                    signedup = !signedup;
                                  });
                                  if (_key.currentState!.validate()) {
                                    Timer(Duration(seconds: 2), () {
                                      registerUser(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Already have accout ? then log-in',
                              style: TextStyle(color: Colors.amber),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: MaterialButton(
                                color: Colors.pinkAccent,
                                hoverColor: Colors.blue,
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                                },
                                child: Text(
                                  'log-in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
