// import 'package:bidu_demo/presentation/screen/home_screen.dart';
import 'package:bidu_demo/data/repositories/category_repository.dart';
import 'package:bidu_demo/data/repositories/product_repository.dart';
import 'package:bidu_demo/logic/blocs/home_bloc.dart';
import 'package:bidu_demo/logic/blocs/product_detail_bloc.dart';
import 'package:bidu_demo/modules/home/screen/home_screen.dart';
import 'package:bidu_demo/modules/product_detail/screen/product_detail_screen.dart';
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
    final productRepository = ProductRepository();
    final categoryRepository = CategoryRepository();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => MultiProvider(
              providers: [
                Provider<ProductRepository>.value(value: productRepository),
                Provider<CategoryRepository>.value(value: categoryRepository),
                ProxyProvider2<ProductRepository, CategoryRepository, HomeBloc>(
                  update: (BuildContext _, ProductRepository productRepo,
                          categoryRepo, HomeBloc? oldWidget) =>
                      oldWidget ??
                      HomeBloc(
                        productRepository: productRepo,
                        categoryRepository: categoryRepo,
                      ),
                  dispose: (context, HomeBloc bloc) => bloc.dispose(),
                ),
              ],
              child: MultiProvider(providers: [
                Provider<ProductRepository>.value(value: productRepository),
                ProxyProvider<ProductRepository, ProductDetailBloc>(
                  update: (context, value, previous) =>
                      previous ??
                      ProductDetailBloc(
                        productRepository: value,
                      ),
                ),
              ], child: const HomeScreen()),
            ),
        ProductDetailsScreen.routeName: (context) =>
            const ProductDetailsScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: ThemeData(
        //TODO: edit iconTheme,...
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.grey),
        fontFamily: 'Lexend',
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
    );
  }
}
