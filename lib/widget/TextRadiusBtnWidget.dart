import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class TextRadiusBtnWidget extends StatelessWidget {
  Color backgroundColor;
  Color textColors;
  double radius;
  String textMsg;
  Function onBack;
  double height ;
  double marginLR ;

  TextRadiusBtnWidget(this.backgroundColor, this.textColors, this.radius,
      this.textMsg, this.onBack,{this.height=46,this.marginLR=10});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: marginLR, right: marginLR),
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: Center(
          child: Text(
            textMsg,
            style: TextStyle(color: textColors),
          ),
        ),
      ),
      onTap: () {
        onBack();
      },
    );
  }
}
