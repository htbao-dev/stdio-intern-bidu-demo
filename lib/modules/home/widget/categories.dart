import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<BannerAndCategory>(
      stream: Provider.of<HomeBloc>(context).bannerAndCategoryStream,
      builder:
          (BuildContext context, AsyncSnapshot<BannerAndCategory> snapshot) {
        final List<Category> listCategory = snapshot.data?.listCategory ?? [];
        return Center(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 16 - 12.5),
              child: AnimatedCrossFade(
                firstChild: Wrap(
                  children: listCategory
                      .sublist(0, 9)
                      .map<Widget>((e) => _categoryItem(e))
                      .toList()
                    ..add(_seemore()),
                ),
                secondChild: Wrap(
                  children: listCategory
                      .map<Widget>((e) => _categoryItem(e))
                      .toList(),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              )),
        );
      },
    );
  }

  Widget _categoryItem(Category category, {bool isSeemreBtn = false}) {
    return Container(
      width: 48,
      margin: const EdgeInsets.symmetric(horizontal: 12.5),
      child: Column(
        children: [
          isSeemreBtn
              ? Image.asset(
                  category.avatar,
                  width: 32,
                  height: 32,
                )
              : Image.network(
                  category.avatar,
                  width: 32,
                  height: 32,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              category.name,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seemore() {
    final _seemore = Category(
        name: 'Xem thêm', avatar: 'assets/icons/icon_category_seemore.png');
    return _categoryItem(_seemore, isSeemreBtn: true);
  }

  @override
  bool get wantKeepAlive => true;
}
