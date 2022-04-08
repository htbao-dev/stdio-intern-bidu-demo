import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: null,
          child: Stack(children: [
            Container(
                decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xffFF7C79),
                    Color(0xffE812A4),
                  ]),
            )),
            Align(
                child: SvgPicture.asset(
                  'assets/icons/icon-bidu.svg',
                  color: Colors.white,
                  width: 30,
                ),
                alignment: Alignment.center),
          ]),
        ),
      ),
    );
  }
}
