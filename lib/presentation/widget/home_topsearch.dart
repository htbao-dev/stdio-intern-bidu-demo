import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTopSearch extends StatelessWidget {
  const HomeTopSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeGroupContent(
      title: 'Top Tìm Kiếm',
      seeMore: () {
        print('see more');
      },
      child: SizedBox(
        height: 175,
        child: StreamBuilder<HomeState>(
            stream: Provider.of<HomeBloc>(context).topSearchStream,
            builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
              final List<Keyword> listItem;
              if (snapshot.data is TopSearchLoaded) {
                listItem = (snapshot.data as TopSearchLoaded).listTopKeyword;
              } else {
                listItem = [];
              }

              return MyListView(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return ListItem.forTopSearch(
                    keyword: listItem[index],
                  );
                },
              );
            }),
        // BlocBuilder<HomeBloc, HomeState>(
        //   buildWhen: (previous, current) => current is TopSearchLoaded,
        //   builder: (context, state) {
        //     if (state is TopSearchLoaded) {
        //       final listKeyword = state.listTopKeyword;
        //       return MyListView(
        //           itemCount: listKeyword.length,
        //           itemBuilder: (context, index) => ListItem.forTopSearch(
        //                 keyword: listKeyword[index],
        //               ));
        //     }
        //     return Container();
        //   },
        // ),
      ),
    );
  }
}
