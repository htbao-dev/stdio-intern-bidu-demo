import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/modules/common_widget/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBottomAppBar extends StatelessWidget {
  final String addToCartText = 'Thêm vào giỏ';
  final String buyNowText = 'Mua ngay';
  const MyBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff1A1A1A),
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
                      iconCartAsset,
                      color: Colors.white,
                      height: 24,
                      width: 24,
                    ),
                    Text(
                      addToCartText,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: const Color(0xffC9C9C9),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  heightFactor: 1,
                  child: GradientText(
                    buyNowText,
                    gradient: const LinearGradient(
                        colors: [Color(0xffFD374F), Color(0xffFD37AE)]),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
