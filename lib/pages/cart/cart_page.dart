import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlineshop/base/no_data_page.dart';
import 'package:onlineshop/controller/auth_controller.dart';
import 'package:onlineshop/controller/location_controller.dart';
import 'package:onlineshop/controller/recommended_page_controller.dart';
import 'package:onlineshop/controller/cart_controller.dart';
import 'package:onlineshop/controller/product_controller.dart';
import 'package:onlineshop/controller/user_controller.dart';
import 'package:onlineshop/route/route_helper.dart';
import 'package:onlineshop/utils/app_constants.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/utils/format.dart';
import 'package:onlineshop/widgets/app_icons.dart';
import 'package:onlineshop/widgets/subtitle_text.dart';
import 'package:onlineshop/widgets/title_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Stack(
        children: [
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
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                      icColor: Colors.white,
                      bgColor: AppColors.mainColor,
                      iconSize: Dimensions.icon24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.initial);
                        },
                        child: AppIcon(
                          icon: Icons.home_outlined,
                          icColor: Colors.white,
                          bgColor: AppColors.mainColor,
                          iconSize: Dimensions.icon24,
                        ),
                      ),
                      SizedBox(width: Dimensions.width20),
                      AppIcon(
                        icon: Icons.favorite_outline,
                        icColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        iconSize: Dimensions.icon24,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimensions.statusBarWidth + 70,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child:
                            GetBuilder<CartController>(builder: ((controller) {
                          var cartList = controller.getItems;
                          return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20),
                                // height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                // color: Colors.blue,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                child: Row(
                                  children: [
                                    /* Gambar Produk */
                                    GestureDetector(
                                      onTap: () {
                                        var productIndex =
                                            Get.find<ProductController>()
                                                .productList
                                                .indexOf(
                                                    cartList[index].product!);

                                        // Ini optional kalau tidak pakai recommended page
                                        if (productIndex >= 0) {
                                          Get.toNamed(RouteHelper.getProduct(
                                              productIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedPageController>()
                                              .recommendedList
                                              .indexOf(
                                                  cartList[index].product!);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar("Mohon Maaf",
                                                "Review Produk tidak dapat dilakukan saat ini",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                          } else {
                                            Get.toNamed(
                                                RouteHelper.getrecommended(
                                                    recommendedIndex,
                                                    "recommendedpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height100,
                                        height: Dimensions.height100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstans.baseUrl +
                                                    AppConstans.uploadUrl +
                                                    controller
                                                        .getItems[index].img!),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    /* Product Description */
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.height100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TitleText(
                                              text: controller
                                                  .getItems[index].name!,
                                              color: Colors.black,
                                            ),
                                            SubTitleText(
                                              text: controller
                                                  .getItems[index].brand
                                                  .toString(),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TitleText(
                                                    text: CurrencyFormat
                                                        .convertToIdr(
                                                            controller
                                                                .getItems[index]
                                                                .price,
                                                            0),
                                                    size: Dimensions.font20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  height: Dimensions.height45,
                                                  width: Dimensions.height100,
                                                  padding: EdgeInsets.only(
                                                    top: Dimensions.height5,
                                                    bottom: Dimensions.height5,
                                                    right: Dimensions.width5,
                                                    left: Dimensions.width5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: AppIcon(
                                                            icon: Icons.remove,
                                                            size: Dimensions
                                                                .height30,
                                                            bgColor: AppColors
                                                                .iconColor2,
                                                          )),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      TitleText(
                                                        text: cartList[index]
                                                            .quantity
                                                            .toString() //recommendedList.inCartItems
                                                            .toString(),
                                                        size: Dimensions.font20,
                                                      ),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: AppIcon(
                                                            icon: Icons.add,
                                                            size: Dimensions
                                                                .height30,
                                                            bgColor: AppColors
                                                                .iconColor2,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          );
                        }))),
                  )
                : const NoDataPage(text: "Your Cart is Empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: ((controller) {
        var cartList = controller.getItems;
        return Container(
          height: cartList.isEmpty
              ? 0
              : Dimensions.screenHeight / (Dimensions.screenHeight / 120),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width45,
            vertical: Dimensions.height30,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                )
              ],
              color: AppColors.secondaryColor),
          // Bottom Bar
          child: GestureDetector(
            onTap: () {
              // print("Tapped");
              // controller.addToHistory();
              Get.toNamed(RouteHelper.getCheckout());
            },
            child: Container(
              width: Dimensions.screenWidth / (Dimensions.screenWidth / 270),
              height: Dimensions.screenHeight / (Dimensions.screenHeight / 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: TitleText(
                  text: "Checkout",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      })),
    );
  }
}
