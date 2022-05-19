import 'package:bidu_demo/common/constant.dart';
import 'package:bidu_demo/data/models/product.dart';
import 'package:bidu_demo/data/repositories/category_repository.dart';
import 'package:bidu_demo/data/repositories/product_repository.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/home/home_screen.dart';
import 'package:bidu_demo/modules/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const BiduApp());
}

class BiduApp extends StatelessWidget {
  const BiduApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<IProductRepository>(create: (_) => ProductRepository()),
          Provider<ICategoryRepository>(create: (_) => CategoryRepository()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) {
            //TODO: tach file
            switch (settings.name) {
              case HomeScreen.routeName:
                return MaterialPageRoute(
                  builder: (_) => ProxyProvider2<IProductRepository,
                      ICategoryRepository, HomeBloc>(
                    update:
                        (_, productRepo, categoryRepo, HomeBloc? oldWidget) =>
                            oldWidget ??
                            HomeBloc(
                              productRepository: productRepo,
                              categoryRepository: categoryRepo,
                            ),
                    dispose: (_, bloc) => bloc.dispose(),
                    child: const HomeScreen(),
                  ),
                );
              case ProductDetailsScreen.routeName:
                return MaterialPageRoute(
                  builder: (_) =>
                      ProxyProvider<IProductRepository, ProductDetailBloc>(
                    update: (_, productRepo, oldWidget) =>
                        oldWidget ??
                        ProductDetailBloc(productRepository: productRepo),
                    child: ProductDetailsScreen(
                      product: settings.arguments as Product,
                    ),
                  ),
                );
              default:
                throw Exception('Unknown route: ${settings.name}');
            }
          },
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: const ColorScheme.light(
                secondary: Colors.grey,
                primary: Colors.white,
              ),
              fontFamily: 'Lexend',
              textTheme: const TextTheme(
                  bodyText2: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryBlackColor),
                  headline6: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryBlackColor))),
        ));
  }
}
