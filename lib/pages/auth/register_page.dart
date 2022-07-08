import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/base/custom_snackbar.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/models/register_model.dart';
import 'package:onlineshop/pages/auth/login_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_text_field.dart';
import 'package:onlineshop/widgets/title_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var genderController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImg = [
      "twitter.png",
      "facebook.png",
      "google.png",
    ];

    void registration(AuthController authController) {
      String name = nameController.text.trim();
      String gender = genderController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        customSnackBar("Please input your name!", title: "Name is empty");
      } else if (gender.isEmpty) {
        customSnackBar("Please input your gender!", title: "Gender is empty");
      } else if (phone.isEmpty) {
        customSnackBar("Please input your phone number!",
            title: "Phone number is empty");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        customSnackBar("Your phone number is not valid!",
            title: "Phone number not valid");
      } else if (email.isEmpty) {
        customSnackBar("Please input your email!", title: "Email is empty");
      } else if (!GetUtils.isEmail(email)) {
        customSnackBar("Your email is not valid!", title: "Email not valid");
      } else if (password.isEmpty) {
        customSnackBar("Please input your password!",
            title: "password is empty");
      } else if (password.length < 6) {
        customSnackBar("Your password must be more than 6 characters",
            title: "Password is too sort");
      } else {
        RegisterModel registerModel = RegisterModel(
          name: name,
          gender: gender,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(registerModel).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getLogin());
            customSnackBar("Congrats your registration is success",
                title: "Registration Success", color: Colors.greenAccent);
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
        padding: EdgeInsets.only(top: Dimensions.height10),
        child: GetBuilder<AuthController>(
          builder: ((authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Icon
                          Container(
                            height: Dimensions.screenHeight /
                                (Dimensions.screenHeight / 150),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                "assets/images/registerui.png",
                              ),
                            )),
                          ),
                          SizedBox(
                            height: Dimensions.height50,
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
                                      "Sign Up",
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
                                      height: Dimensions.height10,
                                    ),
                                    // Name
                                    AppTextFieldPage(
                                      textController: nameController,
                                      hintText: "Name",
                                      icon: Icons.person_outline_rounded,
                                      // color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height5,
                                    ),
                                    // Gender
                                    AppTextFieldPage(
                                      textController: genderController,
                                      hintText: "Gender",
                                      icon: Icons.male_outlined,
                                      // color: AppColors.mainColor,
                                    ),

                                    SizedBox(
                                      height: Dimensions.height5,
                                    ),
                                    // Phone
                                    AppTextFieldPage(
                                      textController: phoneController,
                                      hintText: "Phone",
                                      icon: Icons.phone_outlined,
                                      // color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height5,
                                    ),
                                    // Email
                                    AppTextFieldPage(
                                      textController: emailController,
                                      hintText: "Email",
                                      icon: Icons.email_outlined,
                                      // color: AppColors.mainColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height5,
                                    ),
                                    // Password
                                    AppTextFieldPage(
                                      textHide: true,
                                      textController: passwordController,
                                      hintText: "Password",
                                      icon: Icons.lock_outline,
                                      // color: AppColors.mainColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          // Sign Up button

                          Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Container(
                                  width: 280,
                                  child: Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "By signing up, you’re agree to our ",
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: Dimensions.font14)),
                                      TextSpan(
                                          text: "Terms & Conditions",
                                          style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: Dimensions.font14)),
                                      TextSpan(
                                          text: " and ",
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: Dimensions.font14)),
                                      TextSpan(
                                          text: "Privacy Policy",
                                          style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: Dimensions.font14)),
                                    ]),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  registration(authController);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius30),
                                    color: AppColors.mainColor,
                                  ),
                                  child: Center(
                                    child: TitleText(
                                      text: "Sign Up",
                                      color: Colors.white,
                                      size: Dimensions.font20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Have an account already? ",
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
                                            () => LoginPage(),
                                            transition: Transition.fade),
                                      text: "Sign In",
                                      style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: Dimensions.font14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Sign Up Option
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                        ],
                      ),
                    ),
                  )
                : const CustomLoader();
          }),
        ),
      ),
    );
  }
}
