// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class SubTitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SubTitleText({
    Key? key,
    this.color = const Color(0xFF778da9),
    required this.text,
    this.size = 13,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
