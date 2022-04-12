import 'package:bidu_demo/data/models/category.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomeState>(
      stream: Provider.of<HomeBloc>(context).bannerAndCategoryStream,
      builder: (BuildContext context, AsyncSnapshot<HomeState> snapshot) {
        final List<Category> listCategory;
        if (snapshot.data is BannerAndCategoryLoaded) {
          listCategory =
              (snapshot.data as BannerAndCategoryLoaded).listCategory;
        } else {
          listCategory = [];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final category in listCategory) _categoryItem(category)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _categoryItem(Category category) {
    return Container(
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      // padding: const EdgeInsets.symmetric(horizontal: 17),
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // ),
      child: Column(
        children: [
          Image.network(
            category.avatar,
            width: 25,
            height: 40,
          ),
          Text(
            category.name,
            maxLines: 2,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
