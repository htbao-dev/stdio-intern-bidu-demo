import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/home/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSuggestion extends StatefulWidget {
  const HomeSuggestion({Key? key}) : super(key: key);

  @override
  State<HomeSuggestion> createState() => _HomeSuggestionState();
}

class _HomeSuggestionState extends State<HomeSuggestion>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeGroupContent(
      title: 'Gợi Ý Cho Bạn',
      seeMore: () {
        // ignore: avoid_print
        print('see more');
      },
      child: StreamBuilder<List<Product>>(
          stream: Provider.of<HomeBloc>(context).suggestProductStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            final List<Product> listProduct = snapshot.data ?? [];
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(listProduct.length, (index) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    child: SuggestProductItem(product: listProduct[index]));
              }),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
