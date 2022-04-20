import 'package:bidu_demo/modules/common_widget/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottmAppBar extends StatelessWidget {
  const BottmAppBar({
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
                      'assets/icons/icon_cart.svg',
                      color: Colors.white,
                      height: 24,
                      width: 24,
                    ),
                    const Text(
                      'Thêm vào giỏ',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 28,
                color: const Color(0xffC9C9C9),
              ),
              const Expanded(
                flex: 1,
                child: Align(
                  heightFactor: 1,
                  child: GradientText(
                    'Mua ngay',
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
