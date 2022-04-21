import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/modules/home/widget/group_content.dart';
import 'package:bidu_demo/modules/home/widget/item.dart';
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
      title: 'Top Người Bán',
      seeMore: () {},
      child: StreamBuilder<List<Shop>>(
        stream: context.read<HomeBloc>().topSellerStream,
        builder: (BuildContext context, AsyncSnapshot<List<Shop>> snapshot) {
          final List<Shop> listItem = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: listItem.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TopSellerItem(
                        shop: listItem[index],
                        rank: index + 1,
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Xem thêm',
                          style: TextStyle(
                              // color: Colors.blue,
                              )),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xffFD37AE),
                      )
                    ],
                  ),
                ),
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
