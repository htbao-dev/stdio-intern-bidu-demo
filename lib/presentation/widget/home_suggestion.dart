import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:flutter/material.dart';

class HomeSuggestion extends StatelessWidget {
  const HomeSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeGroupContent(
        title: 'Gợi Ý Cho Bạn',
        seeMore: () {
          // ignore: avoid_print
          print('see more');
        },
        child: Container()
        // StreamBuilder<HomeState>(
        //     stream: Provider.of<HomeBloc>(context).stream,
        //     builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
        //       final List<Product> listItem;
        //       if (snapshot.hasData is SuggestionLoaded) {
        //         listItem = (snapshot.data as SuggestionLoaded).listSuggestion;
        //       } else {
        //         listItem = [];
        //       }

        //       return MyListView(
        //         itemCount: listItem.length,
        //         itemBuilder: (context, index) {
        //           return ListItem.forSuggestion(
        //             product: listItem[index],
        //           );
        //         },
        //       );
        //     }),

        //////
        // BlocBuilder<HomeBloc, HomeState>(
        //   buildWhen: (previous, current) => current is NewestProductLoaded,
        //   builder: (context, state) {
        //     if (state is NewestProductLoaded) {
        //       final listProduct = state.listProduct;
        //       return Container();
        //     }
        //     return Container();
        //   },
        // ),
        );
  }
}
