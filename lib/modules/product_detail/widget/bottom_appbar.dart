import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:bidu_demo/modules/common_widget/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryBlackColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.iconCartAsset,
                      color: Colors.white,
                      height: 24,
                      width: 24,
                    ),
                    const Text(
                      Strings.addToCart,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: kPrimaryGreyColor,
              ),
              const Expanded(
                flex: 1,
                child: Align(
                  heightFactor: 1,
                  child: GradientText(
                    Strings.buyNow,
                    gradient: LinearGradient(
                        colors: [Color(0xffFD374F), Color(0xffFD37AE)]),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
