import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/appbar.dart';
import 'package:bidu_demo/modules/home/widget/back_to_top.dart';
import 'package:bidu_demo/modules/home/widget/banner.dart';
import 'package:bidu_demo/modules/home/widget/categories.dart';
import 'package:bidu_demo/modules/home/widget/fab.dart';
import 'package:bidu_demo/modules/home/widget/navbar.dart';
import 'package:bidu_demo/modules/home/widget/newest.dart';
import 'package:bidu_demo/modules/home/widget/suggestion.dart';
import 'package:bidu_demo/modules/home/widget/topproduct.dart';
import 'package:bidu_demo/modules/home/widget/topsearch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();
//TODO: livestream background toi
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<HomeBloc>().initLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appBar(),
      body: Stack(children: [
        SmartRefresher(
          enablePullDown: true,
          header: const MaterialClassicHeader(
            color: Colors.black,
          ),
          controller: _refreshController,
          onRefresh: () => _onRefresh(),
          child: ListView(
            controller: _scrollController,
            children: [
              const HomeBanner(),
              HomeCategories(
                scrollController: _scrollController,
              ),
              const HomeNewest(),
              const HomeTopSearch(),
              const HomeTopProduct(),
              const HomeSuggestion()
            ],
          ),
        ),
        StreamBuilder(
          stream: context.read<HomeBloc>().backToTopStream,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return Align(
                alignment: const Alignment(0, 0.8),
                child: BackTopTop(
                  onPressed: _scrollToTop,
                ),
              );
            }
            return const SizedBox();
          },
        )
      ]),
      bottomNavigationBar: const HomeNavBar(),
      floatingActionButton: const HomeFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<HomeBloc>().loadSuggestProduct();
    }

    if (_scrollController.offset >= 400) {
      context.read<HomeBloc>().showBackToTop(true);
    } else {
      context.read<HomeBloc>().showBackToTop(false);
    }
  }

  void _onRefresh() async {
    await context.read<HomeBloc>().refesh();
    _refreshController.refreshCompleted();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
