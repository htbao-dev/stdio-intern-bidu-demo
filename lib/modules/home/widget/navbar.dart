import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _button('assets/icons/icon-shopping.svg',
                index: 0, onPressed: () {}),
            _button('assets/icons/icon-bidu.svg', index: 1, onPressed: () {}),
            _button('assets/icons/icon-heart.svg', index: 2, onPressed: () {}),
            _button('assets/icons/icon-categories.svg',
                index: 3, onPressed: () {}),
            _button('assets/icons/icon-person.svg', index: 4, onPressed: () {}),
            const SizedBox(width: 90),
          ],
        ));
  }

  Widget _button(String assets,
      {required int index, required VoidCallback onPressed}) {
    const _selectedColor = Color(0xffE812A4);
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
