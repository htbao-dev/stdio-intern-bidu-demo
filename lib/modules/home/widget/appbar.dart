import 'package:bidu_demo/common/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SvgPicture.asset(
        biduLogoAsset,
        // color: Colors.white,
        // height: 24,
      ),
    ),
    actions: [
      _appBarButton(
        child: SvgPicture.asset(iconSearchAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(iconSendAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(iconBellAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(iconCartAsset),
        onPressed: () {},
      ),
    ],
    backgroundColor: Colors.white,
    elevation: 1,
  );
}

Widget _appBarButton({required Widget child, required VoidCallback onPressed}) {
  return IconButton(
    icon: child,
    splashRadius: 25,
    onPressed: onPressed,
  );
}
