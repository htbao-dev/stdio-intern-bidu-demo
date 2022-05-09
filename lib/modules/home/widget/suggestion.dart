import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String _kSuggestText = 'Gợi Ý Cho Bạn';

class HomeSuggestion extends StatefulWidget {
  final int numberItemInRow;
  const HomeSuggestion({Key? key, required this.numberItemInRow})
      : super(key: key);

  @override
  State<HomeSuggestion> createState() => _HomeSuggestionState();
}

class _HomeSuggestionState extends State<HomeSuggestion>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    double itemSize =
        (MediaQuery.of(context).size.width - kVerticalPadding * 2) /
            widget.numberItemInRow;
    super.build(context);
    return HomeGroupContent(
      title: _kSuggestText,
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
              spacing: kHorizontalPadding,
              runSpacing: kHorizontalPadding,
              children: List.generate(listProduct.length, (index) {
                return SizedBox(
                    width: itemSize,
                    child: SuggestProductItem(
                      product: listProduct[index],
                      itemSize: itemSize,
                    ));
              }),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
