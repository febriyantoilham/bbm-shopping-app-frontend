import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/custom_loader.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/pages/auth/register_page.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/subtitle_text.dart';
import 'package:onlineshop/widgets/title_text.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    // Top Icon
                    Container(
                      height: Dimensions.height20 * 10,
                      width: Dimensions.width20 * 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainColor,
                        image: DecorationImage(
                          image: AssetImage("assets/images/seclogo.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width30),
                      // width: Dimensions.width30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Let’s Get",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: AppColors.mainTextColor,
                            ),
                          ),
                          const Text(
                            "Started",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: AppColors.mainTextColor,
                            ),
                          ),
                          SubTitleText(
                              text:
                                  "Explorer everything you need to find your"),
                          SubTitleText(text: "best order.")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Get.toNamed(RouteHelper.getSignUp());
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height10),
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            width: Dimensions.width30 * 10,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainWhite,
                                border: Border.all(
                                    width: 1, color: AppColors.mainColor)),
                            child: Center(
                              child: TitleText(
                                text: "Create an account",
                                color: AppColors.mainTextColor,
                                size: Dimensions.font20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Get.toNamed(RouteHelper.getLogin());
                          }),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height10),
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            width: Dimensions.width30 * 10,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainWhite,
                                border: Border.all(
                                    width: 1, color: AppColors.mainColor)),
                            child: Center(
                              child: TitleText(
                                text: "Sign In",
                                color: AppColors.mainTextColor,
                                size: Dimensions.font20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: Dimensions.height10,
                    ),
                  ],
                )
              : const CustomLoader();
        }));
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
      margin: EdgeInsets.all(Dimensions.height10),
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
