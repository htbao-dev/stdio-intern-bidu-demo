import 'package:bidu_demo/data/models/banner_category.dart';
import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeCategories extends StatefulWidget {
  final ScrollController scrollController;
  const HomeCategories({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<BannerAndCategory>(
      stream: Provider.of<HomeBloc>(context).bannerAndCategoryStream,
      builder:
          (BuildContext context, AsyncSnapshot<BannerAndCategory> snapshot) {
        final List<Widget> listExpand = (snapshot.data?.listCategory ?? [])
            .map<Widget>((e) => _categoryItem(e))
            .toList();
        final List<Widget> listCollapse = listExpand.length > 9
            ? (listExpand.sublist(0, 9)..add(_seemore()))
            : listExpand;

        return Center(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 16 - 12.5),
              child: AnimatedCrossFade(
                firstChild: Wrap(
                  children: listCollapse,
                ),
                secondChild: Wrap(
                  children: listExpand,
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

  Widget _categoryItem(Category category,
      {bool isSeemreBtn = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 12.5),
        child: Column(
          children: [
            isSeemreBtn
                ? SvgPicture.asset(
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
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _seemore() {
    final _seemore = Category(
        name: 'Xem thêm', avatar: 'assets/icons/icon_category_seemore.svg');
    return _categoryItem(_seemore, isSeemreBtn: true, onTap: () {
      setState(() {
        isExpanded = !isExpanded;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll() {
    if (widget.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        // widget.scrollController.offset >= 100 &&
        isExpanded) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
