import 'package:flutter/material.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';
import 'package:onlineshop/widgets/icons_texts_widget.dart';
import 'package:onlineshop/widgets/subtitle_text.dart';
import 'package:onlineshop/widgets/title_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String brand;
  final String subCategory;
  const AppColumn(
      {Key? key,
      required this.text,
      required this.brand,
      required this.subCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          text: brand,
          size: Dimensions.font14,
          color: AppColors.textColor,
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        TitleText(
          text: text,
          size: Dimensions.font18,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        TitleText(
          text: subCategory,
          size: Dimensions.font14,
          color: AppColors.textColor,
        ),
        // Row(
        //   children: [
        //     Wrap(
        //       children: List.generate(
        //           5,
        //           (index) => const Icon(
        //                 Icons.star,
        //                 color: AppColors.mainColor,
        //                 size: 15,
        //               )),
        //     ),
        //     SizedBox(
        //       width: Dimensions.width10,
        //     ),
        //     SubTitleText(text: "4.5"),
        //   ],
        // ),
      ],
    );
  }
}
