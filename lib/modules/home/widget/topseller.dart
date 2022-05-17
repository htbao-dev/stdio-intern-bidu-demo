import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/common_widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTopSeller extends StatefulWidget {
  const HomeTopSeller({Key? key}) : super(key: key);

  @override
  State<HomeTopSeller> createState() => _HomeTopSellerState();
}

class _HomeTopSellerState extends State<HomeTopSeller>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomeGroupContent(
      title: Strings.topSeller,
      padding: const EdgeInsets.only(top: kVerticalPadding),
      seeMore: () {},
      child: StreamBuilder<List<Shop>>(
        stream: context.read<HomeBloc>().topSellerStream,
        builder: (BuildContext context, AsyncSnapshot<List<Shop>> snapshot) {
          final List<Shop> listItem = snapshot.data ?? [];
          final List<Shop> listShow;
          final List<Shop> listSeemore;
          if (listItem.length > 3) {
            listShow = listItem.sublist(0, 3);
            listSeemore = listItem.sublist(3);
          } else {
            listShow = listItem;
            listSeemore = [];
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: listShow.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TopSellerItem(
                        shop: listShow[index],
                        rank: index + 1,
                      );
                    }),
                _SeemoreSeller(
                  listItem: listSeemore,
                  key: UniqueKey(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SeemoreSeller extends StatefulWidget {
  final int rankStart;
  final List<Shop> listItem;
  const _SeemoreSeller({Key? key, required this.listItem, this.rankStart = 3})
      : super(key: key);

  @override
  State<_SeemoreSeller> createState() => _SeemoreSellerState();
}

class _SeemoreSellerState extends State<_SeemoreSeller> {
  late bool _isSeeMore;

  @override
  void initState() {
    super.initState();
    _isSeeMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          crossFadeState:
              _isSeeMore ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(
            width: double.infinity,
          ),
          secondChild: _listRank(),
          duration: const Duration(milliseconds: 300),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: kVerticalPadding, bottom: 26),
            child: _isSeeMore ? _buttonHide(context) : _buttonSeemore(context),
          ),
          onTap: () {
            setState(() {
              if (_isSeeMore) {
                _isSeeMore = false;
              } else {
                _isSeeMore = true;
              }
            });
          },
        ),
      ],
    );
  }

  Widget _listRank() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: widget.listItem.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TopSellerItem(
            shop: widget.listItem[index],
            rank: widget.rankStart + index + 1,
          );
        });
  }

  Widget _buttonSeemore(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.seemore, style: Theme.of(context).textTheme.bodyText2!),
        const Icon(
          Icons.keyboard_arrow_down,
          color: kPrimaryPinkColor,
        )
      ],
    );
  }

  Widget _buttonHide(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Strings.collapse, style: Theme.of(context).textTheme.bodyText2!),
        const Icon(
          Icons.keyboard_arrow_up,
          color: kPrimaryPinkColor,
        )
      ],
    );
  }
}
