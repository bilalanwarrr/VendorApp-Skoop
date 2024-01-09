// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendorapp/interface/views/controllers/user_controller.dart';
import 'package:vendorapp/interface/views/home_view.dart';

import 'package:vendorapp/interface/views/home_view_tabs/CTAButton.dart';

import '../../utils/constants/constants.dart';
import '../../utils/constants/text_field.dart';
import '../../utils/constants/toast.dart';
import 'signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // var fcmToken;
  // getFcm() async {
  //   fcmToken = await FirebaseMessaging.instance.getToken();
  //   print(fcmToken);
  //   print(fcmToken);
  // }

  bool passwordObscured = true;
  bool isLoading = false;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  UserController userController = Get.find<UserController>();
  Future<bool> signinHere({
    var email,
    var pass,
  }) async {
    try {
      // final tokenn = await FirebaseMessaging.instance.getToken();
      http.Response response = await http.post(
        Uri.parse('$port/signin'),
        body: {
          'email': email,
          'password': pass,
        },
      );
      if (response.statusCode == 200) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        // print(jsonDecode(response.body.toString()));
        showToastShort('Login Successful', kPrimaryGreen);
        var user = jsonDecode(response.body.toString());
        UserController userController = Get.find<UserController>();
        // userController.contact.value = user['vendor']['phone_number'];
        userController.email.value = user['vendor']['email'];
        userController.token.value = user['token'];
        sp.setString('token', user['token']);

        return true;
      } else {
        showToastShort(
            jsonDecode(response.body.toString())["message"], Colors.red);
        // var token = jsonDecode(response.body.toString());
        showToastShort(response.statusCode.toString(), Colors.red);
        return false;
      }
    } catch (e) {
      print(e.toString());
      showToastShort("Server Error", Colors.red);
      return false;
    }
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkLoggedIn();
    // getFcm();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBG,
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Welcome Back',
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      'Login to continue ',
                      style: kSubTitleStyle,
                    ),
                    SizedBox(
                      height: 85.h,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: getTextField(
                        hintText: 'Email',
                        controller: emailC,
                        obsecureText: false,
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 0),
                      child: getTextField(
                        hintText: 'Password',
                        controller: passC,
                        obsecureText: passwordObscured,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordObscured = !passwordObscured;
                            });
                          },
                          icon: Icon(
                            passwordObscured
                                ? Icons.remove_red_eye_rounded
                                : Icons.visibility_off,
                            color: Color(0xffcecece),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       // SizedBox(
                    //       //   width: 10.0,
                    //       // ),
                    //       Container(
                    //         margin: EdgeInsets.only(left: 1.0),
                    //         child: Checkbox(
                    //           value: checkedValue,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               checkedValue = value!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //       Text(
                    //         "Remember Me",
                    //         style: GoogleFonts.manrope(
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: kGreyTextColor,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 100.0,
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           // Navigator.push(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (_) => ForgotScreen()));
                    //         },
                    //         child: Text(
                    //           'Forgot Password?',
                    //           style: GoogleFonts.manrope(
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: 12.sp,
                    //               color: Color(0xffafafaf)),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Checkbox(
                    //   title: Text(
                    //     "Remember Me",
                    //     style: GoogleFonts.manrope(
                    //       fontSize: 12.sp,
                    //       fontWeight: FontWeight.w500,
                    //       color: kGreyTextColor,
                    //     ),
                    //   ),
                    //   secondary: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (_) => ForgotScreen()));
                    //     },
                    //     child: Text(
                    //       'Forgot Password',
                    //       style: GoogleFonts.manrope(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 12.sp,
                    //           color: Color(0xffafafaf)),
                    //     ),
                    //   ),
                    //   tristate: true,
                    //   value: checkedValue,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       checkedValue = newValue!;
                    //     });
                    //   },
                    //   controlAffinity: ListTileControlAffinity
                    //       .leading, //  <-- leading Checkbox
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    isLoading
                        ? SizedBox(
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : getCtaButton(
                            onPress: () async {
                              // print('pressed');
                              // FirebaseMessaging.instance.getToken().then((value) {
                              // signinHere(email: emailC.text, pass: passC.text);
                              // });
                              // final fcmToken =
                              //     await FirebaseMessaging.instance.getToken();
                              // print('fcmToken on tap');
                              // print(fcmToken);
                              print("AT LOGIN");
                              try {
                                if (emailC.text.isEmpty && passC.text.isEmpty) {
                                  showToastShort(
                                      "Email and Password is required",
                                      Colors.red);
                                } else if (emailC.text.isEmpty) {
                                  showToastShort(
                                      "Email is required", Colors.red);
                                } else if (passC.text.isEmpty) {
                                  showToastShort(
                                      "Password is required", Colors.red);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // final token =
                                  //     await FirebaseMessaging.instance.getToken();
                                  bool res = await signinHere(
                                    email: emailC.text,
                                    pass: passC.text,
                                    // tokenn: token,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (res) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeView()),
                                        (route) => false);
                                  }
                                }
                              } catch (e) {
                                // Handle the exception here, show an error message or set a default token.
                                print('Failed to get FCM token: $e');
                              }
                            },
                            color: kPrimaryGreen,
                            text: 'Login'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ? ',
                          style: GoogleFonts.dmSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff868889),
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.dmSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryGreen,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // bottomSheet: Container(
        //   height: 100.0,
        //   color: kBG,
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (_) => SkooperLoginScreen()));
        //     },
        //     child: Center(
        //       child: Text(
        //         'Login as Skooper',
        //         style: kSubTitleStyle,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
