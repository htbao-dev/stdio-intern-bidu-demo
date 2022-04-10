import 'package:bidu_demo/data/repositories/home_repository.dart';
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
import 'package:bidu_demo/presentation/widget/home_topseller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => HomeRepository(),
        child: BlocProvider(
            create: (context) => HomeBloc(
                  homeRepository:
                      RepositoryProvider.of<HomeRepository>(context),
                )
                  ..add(LoadBannerAndCategory())
                  ..add(LoadNewestProduct())
                  ..add(LoadTopProduct())
                  ..add(LoadTopSearch()),
            child: Scaffold(
              appBar: appBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: const [
                    HomeBanner(),
                    HomeCategories(),
                    HomeNewest(),
                    HomeTopSearch(),
                    HomeTopSeller(),
                    HomeTopProduct(),
                    HomeSuggestion()
                  ],
                ),
              ),
              bottomNavigationBar: const HomeNavBar(),
              floatingActionButton: const HomeFloatingButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            )));
  }
}
