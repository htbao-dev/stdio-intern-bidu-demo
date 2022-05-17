import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kHalfHorizontalPadding),
            child: Text(
              '40 ${Strings.feedback}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kHalfHorizontalPadding),
            child: Row(
              // children: [SvgPicture.asset(iconHeartAsset)],
              children: const [
                Icon(
                  Icons.favorite,
                  size: 12,
                  color: Color(0xffFD37AE),
                ),
                SizedBox(width: 4),
                Text(
                  '4.8 / 5.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff9a9a9a),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 68,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _evaluationItem();
              },
              itemCount: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _evaluationItem() {
    return Container(
      width: 202,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 5,
          spreadRadius: 0,
          offset: const Offset(0, 1),
          blurStyle: BlurStyle.normal,
        ),
      ], color: Colors.white),
      child: Row(
        children: [
          Image.asset(
            Assets.imgBiduliveAsset,
            height: 48,
            width: 48,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hài lòng', // khong const vi demo
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Flexible(
                  child: Text('Chất lượng sản phẩm tuyệt vời,...',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff9a9a9a),
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
