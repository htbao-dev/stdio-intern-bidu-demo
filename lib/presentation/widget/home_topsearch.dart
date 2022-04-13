import 'package:bidu_demo/data/models/keyword.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTopSearch extends StatefulWidget {
  const HomeTopSearch({Key? key}) : super(key: key);

  @override
  State<HomeTopSearch> createState() => _HomeTopSearchState();
}

class _HomeTopSearchState extends State<HomeTopSearch>
    with AutomaticKeepAliveClientMixin<HomeTopSearch> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeGroupContent(
      title: 'Top Tìm Kiếm',
      seeMore: () {
        print('see more');
      },
      child: SizedBox(
        height: 200,
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
                  return TopSearchItem(
                    keyword: listItem[index],
                  );
                },
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
