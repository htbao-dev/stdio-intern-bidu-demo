import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BiduLive extends StatelessWidget {
  const BiduLive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF5F5F5),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 20),
            child: SvgPicture.asset('assets/icons/icon_bidulive.svg'),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                padding: const EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 5 + 1,
                itemBuilder: (context, index) {
                  if (index < 5) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: _LiveItem(),
                    );
                  } else {
                    return const _SeeMoreButton();
                  }
                }),
          )
        ],
      ),
    );
  }
}

class _SeeMoreButton extends StatelessWidget {
  const _SeeMoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/icon_live_seemore.svg'),
        const SizedBox(width: 12),
        const Text(
          'Xem thêm',
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}

class _LiveItem extends StatelessWidget {
  const _LiveItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/img_bidulive.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 200,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.5),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.signal_cellular_alt,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 28,
                          width: 28,
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.only(right: 5, bottom: 3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE812A4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/img_live_avt.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Text('Phương Lê',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white)),
                      ],
                    ),
                    const Text(
                      'Sale off 30% to 50% for 21/04 - Fo...',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
