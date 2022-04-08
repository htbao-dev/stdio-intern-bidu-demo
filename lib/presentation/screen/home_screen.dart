import 'package:bidu_demo/presentation/widget/home_appbar.dart';
import 'package:bidu_demo/presentation/widget/home_banner.dart';
import 'package:bidu_demo/presentation/widget/home_categories.dart';
import 'package:bidu_demo/presentation/widget/home_fab.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/home_navbar.dart';
import 'package:bidu_demo/presentation/widget/home_newest.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeBanner(),
            HomeCategories(),
            HomeNewest(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeNavBar(),
      floatingActionButton: const HomeFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
