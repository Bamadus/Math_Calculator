import 'package:flutter/material.dart';

class Number_pad extends StatelessWidget{
  final String? number;
  final Color? color;
  final Color? back_color;
  final double? size;
  final FontWeight? fontweight;

  const Number_pad({
    super.key, 
    this.number,
    this.color,
    this.size,
    this.fontweight,
    this.back_color,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all( 10),
      // padding: EdgeInsets.all(35.0),
      decoration: ShapeDecoration(
        color: back_color ?? (Theme.of(context).brightness == Brightness.dark ? const Color(0xff393d3f) : const Color(0xffdee2e6)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
      // color: Colors.red,
      child: Center(
        child: Text('${number ?? 0}',
        style: TextStyle(
          fontSize: size ?? 25,
          fontFamily: 'Roboto',
          fontWeight: fontweight ?? FontWeight.w400,
          color: color ?? Colors.white,
        ),
            ),
      )
    );
  }
}