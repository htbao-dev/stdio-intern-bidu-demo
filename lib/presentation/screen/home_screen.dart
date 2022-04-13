import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_appbar.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBloc>(
        create: (context) => _homeBloc
          ..add(LoadBannerAndCategory())
          ..add(LoadNewestProduct())
          ..add(LoadTopProduct())
          ..add(LoadTopSearch())
          ..add(LoadSuggestProduct()),
        child: Scaffold(
          extendBody: true,
          appBar: appBar(),
          body: ListView(
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
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }
}
