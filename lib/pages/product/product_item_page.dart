import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_columns.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/expandeble_text_widget.dart';
import 'package:onlineshop/widgets/title_text.dart';

class ProductItemPage extends StatelessWidget {
  final int pageId;
  final String page;

  const ProductItemPage({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().productList[pageId];
    Get.find<RecommendedPageController>()
        .initRecommended(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: Stack(
        children: [
          // Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.statusBarWidth),
              width: Dimensions.screenWidth,
              height: Dimensions.screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstans.baseUrl +
                      AppConstans.uploadUrl +
                      product.img!),
                ),
              ),
            ),
          ),
          // Top Icon
          Positioned(
            top: Dimensions.statusBarWidth,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // optional
                      if (page == "recommendedpage") {
                        Get.toNamed(RouteHelper.getCart());
                      } else {
                        Get.back();
                      }
                    },
                    child: AppIcon(
                      icon: Icons.close,
                      bgColor: AppColors.mainColor,
                      icColor: AppColors.mainWhite,
                      iconSize: Dimensions.height20,
                    ),
                  ),
                  GetBuilder<RecommendedPageController>(builder: ((controller) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              AppIcon(
                                icon: Icons.favorite_outline,
                                bgColor: AppColors.mainColor,
                                icColor: AppColors.mainWhite,
                                iconSize: Dimensions.height20,
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
                                bgColor: AppColors.mainColor,
                                icColor: AppColors.mainWhite,
                                iconSize: Dimensions.height20,
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
          ),
          // Product Content
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.screenWidth,
            child: GetBuilder<RecommendedPageController>(
              builder: ((recommendedList) {
                return Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      top: Dimensions.height30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20),
                      ),
                      color: AppColors.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 30,
                          offset: Offset(0, 0),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppColumn(
                              text: product.name!,
                              brand: product.brand.toString(),
                              subCategory: product.subcategory!,
                            ),
                          ),
                          Container(
                            width: Dimensions.width10 * 12,
                            height: Dimensions.height10 * 4,
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10 - 5,
                              vertical: Dimensions.height10 - 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      recommendedList.setQuantity(false);
                                    },
                                    child: AppIcon(
                                      icon: Icons.remove,
                                      size: Dimensions.height30,
                                      iconSize: Dimensions.height20,
                                      bgColor: Color(0xFFF0FFFF),
                                    )),
                                SizedBox(width: Dimensions.width10 / 2),
                                TitleText(
                                    text:
                                        recommendedList.inCartItems.toString()),
                                SizedBox(width: Dimensions.width10 / 2),
                                GestureDetector(
                                    onTap: () {
                                      recommendedList.setQuantity(true);
                                    },
                                    child: AppIcon(
                                      icon: Icons.add,
                                      size: Dimensions.height30,
                                      iconSize: Dimensions.height20,
                                      bgColor: Color(0xFFF0FFFF),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height20),
                      TitleText(
                        text: "Price",
                        size: Dimensions.font14,
                        color: AppColors.textColor,
                      ),
                      TitleText(
                        text: CurrencyFormat.convertToIdr(product.price, 0),
                        size: Dimensions.font18,
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height20),
                      TitleText(
                        text: "Introduce",
                        size: Dimensions.font14,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              ExpandebleTextWidget(text: product.description!),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          recommendedList.addItem(product);
                        },
                        child: Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height30),
                            width: double.maxFinite,
                            height: Dimensions.height10 * 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20 + 5),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: TitleText(
                                text: "Add to Cart",
                                color: Colors.white,
                                size: Dimensions.font18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      // // Bottom Bar
    );
  }
}
