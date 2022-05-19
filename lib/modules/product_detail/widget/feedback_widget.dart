import 'dart:developer';

import 'package:bidu_demo/common/assets_path.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/common/strings.dart';
import 'package:bidu_demo/data/models/product_detail.dart' as model;
import 'package:flutter/material.dart';

class FeedBackWidget extends StatelessWidget {
  const FeedBackWidget({Key? key, required this.feedbacks}) : super(key: key);

  final model.Feedbacks feedbacks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kHalfHorizontalPadding),
            child: Text(
              '${feedbacks.totalFeedback} ${Strings.feedback}',
              style: const TextStyle(
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
                return _evaluationItem(feedbacks.feedbacks![index]);
              },
              itemCount: feedbacks.feedbacks?.length ?? 0,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _evaluationItem(model.Feedback feedback) {
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
              children: [
                const Text('Hài lòng', // khong const vi demo
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Flexible(
                  child: Text(feedback.content,
                      style: const TextStyle(
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
