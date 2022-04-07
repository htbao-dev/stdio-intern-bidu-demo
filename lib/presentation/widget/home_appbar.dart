import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar appBar() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SvgPicture.asset(
        'assets/icons/logo.svg',
        // color: Colors.white,
        // height: 24,
      ),
    ),
    actions: [
      _appBarButton(
        child: SvgPicture.asset('assets/icons/icon_search.svg'),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset('assets/icons/icon_send.svg'),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset('assets/icons/icon_bell.svg'),
        onPressed: () {},
      ),
      _appBarButton(
        child: SvgPicture.asset('assets/icons/icon_cart.svg'),
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
