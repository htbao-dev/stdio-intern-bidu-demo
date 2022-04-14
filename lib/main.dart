// import 'package:bidu_demo/presentation/screen/home_screen.dart';
import 'package:bidu_demo/data/repositories/home_repository.dart';
import 'package:bidu_demo/logic/blocs/home_bloc/home_bloc.dart';
import 'package:bidu_demo/modules/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(const BiduApp());
}

class BiduApp extends StatelessWidget {
  const BiduApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<HomeRepository>(
            create: (context) => HomeRepository(),
          ),
          ProxyProvider<HomeRepository, HomeBloc>(
            // Provider<HomeBloc>(
            create: (context) => HomeBloc(
              homeRepository: context.read<HomeRepository>(),
            ),
            update:
                (BuildContext _, HomeRepository value, HomeBloc? oldWidget) =>
                    oldWidget ?? HomeBloc(homeRepository: value),
            dispose: (context, HomeBloc bloc) => bloc.dispose(),
          )
        ],
        child: const HomeScreen(),
      ),
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
