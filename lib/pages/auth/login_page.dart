// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/pages/auth/register_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        customSnackBar("Please input your email account!",
            title: "Email Account is empty");
      } else if (password.isEmpty) {
        customSnackBar("Please input your password!",
            title: "password is empty");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
            customSnackBar("Login Success",
                title: "Welcome Back", color: Colors.greenAccent);
          } else {
            customSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Container(
          margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
          child: GetBuilder<AuthController>(builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height:
                          Dimensions.screenHeight - Dimensions.statusBarWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Icon
                          Container(
                            height: Dimensions.height10 * 22,
                            decoration: const BoxDecoration(
                                // shape: BoxShape.circle,
                                // color: AppColors.mainColor,
                                image: DecorationImage(
                              image: AssetImage("assets/images/loginui.png"),
                            )),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width30),
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mainTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width30),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    // Email
                                    AppTextFieldPage(
                                      textController: emailController,
                                      hintText: "Email",
                                      icon: Icons.alternate_email,
                                      // color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    // Password
                                    AppTextFieldPage(
                                      textHide: true,
                                      textController: passwordController,
                                      hintText: "Password",
                                      icon: Icons.lock_outline_rounded,
                                      // color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    // Forgot Password
                                    SizedBox(
                                      width: Dimensions.width10 * 37,
                                      child: RichText(
                                        textAlign: TextAlign.end,
                                        text: TextSpan(
                                          text: "Forgot Password?",
                                          style: TextStyle(
                                            color: AppColors.mainTextColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: Dimensions.font14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  login(authController);
                                }),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    color: AppColors.mainColor,
                                  ),
                                  child: Center(
                                    child: TitleText(
                                      text: "Login",
                                      color: Colors.white,
                                      size: Dimensions.font20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       width: 100,
                              //       height: 0,
                              //       decoration: BoxDecoration(
                              //           border: Border.all(
                              //         color: AppColors.subTitle,
                              //         width: 0.8,
                              //       )),
                              //     ),
                              //     SizedBox(width: Dimensions.width10),
                              //     RichText(
                              //       text: TextSpan(
                              //         text: "Or",
                              //         style: TextStyle(
                              //           color: AppColors.textColor,
                              //           fontSize: Dimensions.font16,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(width: Dimensions.width10),
                              //     Container(
                              //       width: 100,
                              //       height: 0,
                              //       decoration: BoxDecoration(
                              //           border: Border.all(
                              //         color: AppColors.subTitle,
                              //         width: 0.8,
                              //       )),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: Dimensions.height20,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     SocialAuth(
                              //       image: const AssetImage(
                              //           "assets/images/google.png"),
                              //       bgColor: Colors.white,
                              //     ),
                              //     SocialAuth(
                              //       image: const AssetImage(
                              //           "assets/images/twitter.png"),
                              //       bgColor: Colors.white,
                              //     ),
                              //     SocialAuth(
                              //       image: const AssetImage(
                              //           "assets/images/facebook.png"),
                              //       bgColor: Colors.white,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: AppColors.mainTextColor,
                                    fontSize: Dimensions.font14,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(
                                        () => const RegisterPage(),
                                        transition: Transition.fade),
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.font14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                        ],
                      ),
                    ),
                  )
                : const CustomLoader();
          }),
        ));
  }
}

class SocialAuth extends StatelessWidget {
  SocialAuth({
    Key? key,
    required this.image,
    required this.bgColor,
  }) : super(key: key);

  AssetImage image;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      padding: EdgeInsets.all(Dimensions.height10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ]),
      child: CircleAvatar(
        radius: Dimensions.height15,
        backgroundImage: image,
        backgroundColor: bgColor,
      ),
    );
  }
}
