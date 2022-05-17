import 'package:bidu_demo/common/strings.dart';
import 'package:bidu_demo/data/models/product_detail.dart';
import 'package:bidu_demo/data/models/shop.dart';
import 'package:bidu_demo/modules/common_widget/gradient_text.dart';
import 'package:bidu_demo/common/constant.dart';
import 'package:flutter/material.dart';

class DeliveryInfo extends StatelessWidget {
  final ProductDetail productDetail;
  const DeliveryInfo(this.productDetail, {Key? key, required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avgShippingTime = productDetail.shop?.avgShippingTime;
    final timePrepareOrder = productDetail.timePrepareOrder;
    final country = productDetail.shop?.country;
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHalfHorizontalPadding,
          vertical: kVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoText(
              avgShippingTime: avgShippingTime,
              country: country,
            ),
            const SizedBox(
              height: 24,
            ),
            _InfoChart(
              timePrepareOrders: timePrepareOrder,
            )
          ],
        ),
      ),
    );
  }
}

class _InfoChart extends StatelessWidget {
  final List<TimePrepareOrder>? timePrepareOrders;
  const _InfoChart({Key? key, required this.timePrepareOrders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (timePrepareOrders != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Strings.timePrepareProduct),
          const SizedBox(
            height: 10,
          ),
          _chart()
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _rowItem(String title, double value, {bool isPrimary = false}) {
    if (isPrimary) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GradientText(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFD37AE),
                  Color(0xffFD374F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            flex: 1,
          ),
          Flexible(
              flex: 4,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                // color: Colors.red,
                child: LayoutBuilder(
                    builder: (context, constraints) => Row(
                          children: [
                            Container(
                              width: constraints.maxWidth * value / 100,
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: kPrimaryGradientColor,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        )),
              )),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(title),
            flex: 1,
          ),
          Flexible(
              flex: 4,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                // color: Colors.red,
                child: LayoutBuilder(
                    builder: (context, constraints) => Row(
                          children: [
                            Container(
                              width: constraints.maxWidth * value / 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: kPrimaryGreyColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        )),
              )),
        ],
      );
    }
  }

  Widget _chart() {
    int primary = 0;
    Map<TimePrepareOrderDay, String> mapOrderDay = {
      TimePrepareOrderDay.oneDay: '1 ngày',
      TimePrepareOrderDay.twoDay: '2 ngày',
      TimePrepareOrderDay.threeDay: '3 ngày',
      TimePrepareOrderDay.fourDay: '4 ngày',
      TimePrepareOrderDay.greaterThanFourDay: 'Sau 4 ngày',
    };
    for (var i = 1; i < timePrepareOrders!.length; i++) {
      if (timePrepareOrders![i].value > timePrepareOrders![primary].value) {
        primary = i;
      }
    }
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => _rowItem(
          mapOrderDay[timePrepareOrders![index].day]!,
          timePrepareOrders![index].value,
          isPrimary: index == primary),
      itemCount: timePrepareOrders!.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final AvgShippingTime? avgShippingTime;
  final String? country;
  const _InfoText({Key? key, this.avgShippingTime, this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: shippingInfo(),
        ),
        Flexible(
          child: shippingTime(context,
              avgShippingTime: avgShippingTime, country: country),
        ),
      ],
    );
  }

  Widget shippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.deliveryInfo,
        ),
        const SizedBox(
          height: 4,
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'GHTK ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black),
              ),
              TextSpan(
                text: 'đ 30k ~ đ 60k',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xff9a9a9a),
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'J&T ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black),
              ),
              TextSpan(
                text: 'đ 30k ~ đ 60k',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xff9a9a9a),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shippingTime(BuildContext context,
      {required AvgShippingTime? avgShippingTime, required String? country}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.deliveryInfo,
        ),
        const SizedBox(
          height: 4,
        ),
        if (avgShippingTime != null)
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2!,
              children: [
                const TextSpan(
                  text: Strings.average,
                ),
                TextSpan(
                  text: '${avgShippingTime.min}-${avgShippingTime.max} ngày',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        if (country != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                size: 14,
              ),
              Text(country),
            ],
          )
      ],
    );
  }
}
