import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int _selectedIndex = 0;
  final fabSpace = const SizedBox(width: 90);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _button(Assets.iconShoppingAsset, index: 0, onPressed: () {}),
              _button(Assets.iconBiduAsset, index: 1, onPressed: () {}),
              _button(Assets.iconHeartOutlineAsset, index: 2, onPressed: () {}),
              _button(Assets.iconCategoriesAsset, index: 3, onPressed: () {}),
              _button(Assets.iconPersonAsset, index: 4, onPressed: () {}),
              fabSpace, //fab size
            ],
          ),
        ));
  }

  Widget _button(String assets,
      {required int index, required VoidCallback onPressed}) {
    const _selectedColor = kPrimaryPinkColor;
    return IconButton(
      icon: SvgPicture.asset(assets,
          color: _selectedIndex == index ? _selectedColor : null),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        onPressed.call();
      },
    );
  }
}

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Transform.scale(
        scale: 1.2,
        child: FloatingActionButton(
          onPressed: null,
          elevation: 0,
          child: Stack(children: [
            Container(
                decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: kPrimaryGradientColor),
            )),
            Align(
                child: SvgPicture.asset(
                  Assets.iconBiduAsset,
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
