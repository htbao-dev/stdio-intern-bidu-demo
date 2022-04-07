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
            IconButton(
              icon: SvgPicture.asset('assets/icons/icon-shopping.svg',
                  color: null),
              onPressed: () {},
              // title: Text('Home'),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/icon-bidu.svg'),
              onPressed: () {},
              // title: Text('Home'),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/icon-heart.svg'),
              onPressed: () {},
              // title: Text('Home'),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/icon-categories.svg'),
              onPressed: () {},
              // title: Text('Home'),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/icons/icon-person.svg'),
              onPressed: () {},
              // title: Text('Home'),
            ),
            const SizedBox(width: 90),
          ],
        ));
  }
}
