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
    return MultiProvider(
      providers: [
        Provider<IProductRepository>(create: (_) => ProductRepository()),
        Provider<ICategoryRepository>(
            create: (context) => CategoryRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomeScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => ProxyProvider2<IProductRepository,
                          ICategoryRepository, HomeBloc>(
                        update: (BuildContext _, productRepo, categoryRepo,
                                HomeBloc? oldWidget) =>
                            oldWidget ??
                            HomeBloc(
                              productRepository: productRepo,
                              categoryRepository: categoryRepo,
                            ),
                        dispose: (context, HomeBloc bloc) => bloc.dispose(),
                      ));
            case ProductDetailsScreen.routeName:
              return MaterialPageRoute(
                builder: (context) =>
                    ProxyProvider<IProductRepository, ProductDetailBloc>(
                  update: (context, value, previous) =>
                      ProductDetailBloc(productRepository: value),
                  child: ProductDetailsScreen(
                    productId: settings.arguments as String,
                  ),
                ),
              );
            default:
              throw Exception('Unknown route: ${settings.name}');
          }
        },
        theme: ThemeData(
          //TODO: edit iconTheme,...
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.grey,
          ),
          fontFamily: 'Lexend',
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            //   elevation: 0,
            //   brightness: Brightness.light,
            //   iconTheme: IconThemeData(
            //     color: Colors.grey,
            //   ),
          ),
        ),
      ),
    );
  }
}
