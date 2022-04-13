import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/presentation/widget/home_group_content.dart';
import 'package:bidu_demo/presentation/widget/item.dart';
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
      child: StreamBuilder<HomeState>(
          stream: Provider.of<HomeBloc>(context).suggestProductStream,
          builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
            final List<Product> listProduct;
            if (snapshot.data is SuggestProductLoaded) {
              listProduct = (snapshot.data as SuggestProductLoaded).listProduct;
            } else {
              listProduct = [];
            }
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
                  return ListItem.forSuggestProduct(
                      product: listProduct[index]);
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
