import 'package:flutter/material.dart';
import 'package:onlineshop/utils/colors.dart';
import 'package:onlineshop/utils/dimension.dart';

class AppTextFieldPage extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  // final Color color;
  final bool textHide;
  final bool readOnly;
  final bool enable;

  const AppTextFieldPage(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.icon,
      // required this.color,
      this.textHide = false,
      this.enable = true,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          color: Colors.black.withOpacity(0.3),
        ),
        SizedBox(width: Dimensions.width20),
        Expanded(
          child: TextField(
            controller: textController,
            obscureText: textHide,
            readOnly: readOnly,
            enabled: enable,
            style: TextStyle(
              fontSize: Dimensions.font14,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColors.subTitle,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColors.subTitle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
