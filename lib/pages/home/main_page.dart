import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/all_product_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/pages/home/main_page_body.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/subtitle_text.dart';
import 'package:onlineshop/widgets/title_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadResource() async {
    await Get.find<RecommendedPageController>().getRecommendedList();
    await Get.find<ProductController>().getProductList();
    await Get.find<AllProductController>().getAllProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: RefreshIndicator(
          onRefresh: _loadResource,
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.statusBarWidth),
            child: Column(
              children: [
                // header section
                Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height10, bottom: Dimensions.height15),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Dimensions.height10 * 10,
                        height: Dimensions.width45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 + 5),
                            image: const DecorationImage(
                                image: AssetImage("assets/images/seclogo.png"),
                                fit: BoxFit.cover)),
                      ),
                      GetBuilder<RecommendedPageController>(
                          builder: ((controller) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  AppIcon(
                                    icon: Icons.favorite_outline,
                                    bgColor: Colors.black.withOpacity(0),
                                    iconSize: Dimensions.height30,
                                    icColor: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.cart);
                              },
                              child: Stack(
                                children: [
                                  AppIcon(
                                    icon: Icons.shopping_cart_outlined,
                                    bgColor: Colors.black.withOpacity(0),
                                    iconSize: Dimensions.height30,
                                    icColor: Colors.black,
                                  ),
                                  controller.totalItems >= 1
                                      ? Positioned(
                                          right: 0,
                                          top: 0,
                                          child: AppIcon(
                                            icon: Icons.circle,
                                            size: Dimensions.height20,
                                            icColor: Colors.transparent,
                                            bgColor: AppColors.iconColor1,
                                          ),
                                        )
                                      : Container(),
                                  Get.find<RecommendedPageController>()
                                              .totalItems >=
                                          1
                                      ? Positioned(
                                          right: 6,
                                          top: 3,
                                          child: TitleText(
                                            text: Get.find<
                                                    RecommendedPageController>()
                                                .totalItems
                                                .toString(),
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        );
                      }))
                    ],
                  ),
                ),
                // body section
                const Expanded(
                    child: SingleChildScrollView(
                  child: MainPageBody(),
                ))
              ],
            ),
          )),
    );
  }
}
