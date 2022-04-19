import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/home/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double kHomeNewestItemHeight = 320;

class HomeNewest extends StatefulWidget {
  const HomeNewest({Key? key}) : super(key: key);

  @override
  State<HomeNewest> createState() => _HomeNewestState();
}

class _HomeNewestState extends State<HomeNewest>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    String title = 'Sản phẩm mới';
    super.build(context);
    return HomeGroupContent(
      title: title,
      seeMore: () {
        debugPrint('seemore');
      },
      child: SizedBox(
          height: kHomeNewestItemHeight,
          child: StreamBuilder<List<Product>>(
              stream: Provider.of<HomeBloc>(context).newestProductStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                final List<Product> listItem = snapshot.data ?? [];

                return MyListView(
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return NewestProductItem(
                      product: listItem[index],
                    );
                  },
                );
              })),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
