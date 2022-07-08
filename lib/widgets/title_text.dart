// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:onlineshop/utils/dimension.dart';

class TitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  FontWeight fontWeight;
  TextOverflow overFlow;

  TitleText({
    Key? key,
    this.color = const Color(0xFF0d1b2a),
    required this.text,
    this.size = 20,
    this.fontWeight = FontWeight.w400,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: fontWeight,
      ),
    );
  }
}
