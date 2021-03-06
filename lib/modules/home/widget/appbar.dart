import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const double _leadingWidth = 70;
const double _splashRadiusAppbarButton = 25;

AppBar appBar() {
  return AppBar(
    leadingWidth: _leadingWidth,
    leading: Padding(
      padding: const EdgeInsets.only(left: kHalfHorizontalPadding),
      child: SvgPicture.asset(
        Assets.biduLogoAsset,
      ),
    ),
    actions: [
      _appBarButton(
        child: SvgPicture.asset(Assets.iconSearchAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(Assets.iconSendAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(Assets.iconBellAsset),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset(Assets.iconCartAsset),
        onPressed: () {},
      ),
    ],
    elevation: 1,
  );
}

Widget _appBarButton({required Widget child, required VoidCallback onPressed}) {
  return IconButton(
    icon: child,
    splashRadius: _splashRadiusAppbarButton,
    onPressed: onPressed,
  );
}
