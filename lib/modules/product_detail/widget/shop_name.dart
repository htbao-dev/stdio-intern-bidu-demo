import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShopName extends StatelessWidget {
  const ShopName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductDetail>(
      stream: context.read<ProductDetailBloc>().productDetailStream,
      builder: (context, snapshot) {
        final String? avatar = snapshot.data?.shop?.user?.avatar;
        final String? name = snapshot.data?.shop?.name;
        final double? avgRating = snapshot.data?.shop?.avgRating;
        final int? chatResponseByPercent =
            snapshot.data?.shop?.rankPolicy?.data.chatResponseByPercent;
        final int? ranking = snapshot.data?.shop?.ranking;
        return Row(
          children: [
            _avatar(avatar),
            _info(name, avgRating, chatResponseByPercent),
            const Spacer(),
            _ranking(ranking),
          ],
        );
      },
    );
  }

  Widget _avatar(String? url) {
    if (url != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(url),
        radius: 18,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _info(String? name, double? avgRating, int? chatResponseByPercent) {
    if (name != null && avgRating != null && chatResponseByPercent != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            Row(
              children: [
                Text(
                  avgRating.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Container(
                  width: 1,
                  height: 10,
                  color: const Color(0xffC4C4C4),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                ),
                Text(
                  'Tỷ lệ phản hồi Chat $chatResponseByPercent %',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _ranking(int? ranking) {
    if (ranking != null) {
      return Column(
        children: [
          SvgPicture.asset(
            'assets/icons/icon-heart.svg',
            color: const Color(0xffE812A4),
          ),
          Text(
            '$ranking',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xffE812A4),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
