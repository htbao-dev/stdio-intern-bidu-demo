import 'package:bidu_demo/presentation/widget/home_appbar.dart';
import 'package:bidu_demo/presentation/widget/home_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: appBar(),
      body: Container(
        child: ListView(
          children: [],
        ),
      ),
      bottomNavigationBar: const HomeNavBar(),
      floatingActionButton: Transform.scale(
        scale: 1.1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {},
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
