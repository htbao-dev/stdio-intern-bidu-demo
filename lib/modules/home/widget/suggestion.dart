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

//TODO: item chieu cao cung hang
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 310,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemCount: listProduct.length,
                itemBuilder: (context, index) {
                  return SuggestProductItem(product: listProduct[index]);
                },
                physics: const ClampingScrollPhysics(),
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
