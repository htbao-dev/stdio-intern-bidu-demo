import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_appbar.dart';
import 'package:bidu_demo/presentation/widget/home_backtotop.dart';
import 'package:bidu_demo/presentation/widget/home_banner.dart';
import 'package:bidu_demo/presentation/widget/home_categories.dart';
import 'package:bidu_demo/presentation/widget/home_fab.dart';
import 'package:bidu_demo/presentation/widget/home_navbar.dart';
import 'package:bidu_demo/presentation/widget/home_newest.dart';
import 'package:bidu_demo/presentation/widget/home_suggestion.dart';
import 'package:bidu_demo/presentation/widget/home_topproduct.dart';
import 'package:bidu_demo/presentation/widget/home_topsearch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();
  late final HomeBloc _homeBloc;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    _homeBloc = HomeBloc(refreshController: _refreshController);
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBloc>(
        create: (context) => _homeBloc..add(InitLoad()),
        child: Scaffold(
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
                children: const [
                  HomeBanner(),
                  HomeCategories(),
                  HomeNewest(),
                  HomeTopSearch(),
                  // HomeTopSeller(),
                  HomeTopProduct(),
                  HomeSuggestion()
                ],
              ),
            ),
            if (_showBackToTopButton)
              Align(
                  alignment: const Alignment(0, 0.8),
                  child: BackTopTop(
                    onPressed: _scrollToTop,
                  )),
          ]),
          bottomNavigationBar: const HomeNavBar(),
          floatingActionButton: const HomeFloatingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _homeBloc.add(LoadSuggestProduct());
    }

    setState(() {
      if (_scrollController.offset >= 350) {
        _showBackToTopButton = true;
      } else {
        _showBackToTopButton = false;
      }
    });
  }

  void _onRefresh() {
    _homeBloc.add(Refresh());
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
